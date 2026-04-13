Return-Path: <stable+bounces-237473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJqjM8Ii3WkYaQkAu9opvQ
	(envelope-from <stable+bounces-237473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:07:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C5C3F0C6B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0B77316D600
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA06032ABC0;
	Mon, 13 Apr 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b70h4OXC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0793264D7;
	Mon, 13 Apr 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099545; cv=none; b=oFhRYJwJ5KkuEaprXPRCCEpztLt6BP3LpHZcIP9albcD22WuP1T550HmoMlAUcrbv0Uos3z05hCgmiqQyXXKHlr0riXSu8bvnT4npAAhk+k+qZXyQ5k1Sn27T1DYDOjE2WUCo0jyy0WF6k5+ARdffC79noKSXUtAl5sWbhHWa4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099545; c=relaxed/simple;
	bh=Lo7wLq6umeCZCLcBFNCGiboPeMcdcaVutpAAcpz+l2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPADRqZw3mG++Qd1nOnvPVQnjE8remh5qTxvLJxnshmo9YH1vdN2JyTjoj90Q/aj1cxIInyhuEs4TCMhY2C1p2icG8VsW2lUzxW1qt6wofVjt5tEXSc0q8WF2ef1DwRk6kJkRK5j//x/Fty/WwbQakvIEIOa+SMO/4lMFlCnB4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b70h4OXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14609C2BCAF;
	Mon, 13 Apr 2026 16:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099545;
	bh=Lo7wLq6umeCZCLcBFNCGiboPeMcdcaVutpAAcpz+l2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b70h4OXCbJmvCU+YA7clMq0F9k0VPFcHB89jHaK2FD6SxekkwH3WeTwrLQhJiptfJ
	 naJ3c2Dqbo98XcVbp099/AVJpbBsjApZEiSWmd93KSEUBMdLxwSqjA4q6C1TlhqZxs
	 6HPC45eeGaZY4JLAhwBp4EwPMdfKCgcOLIPLubfU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10 380/491] iio: dac: ad5770r: fix error return in ad5770r_read_raw()
Date: Mon, 13 Apr 2026 18:00:25 +0200
Message-ID: <20260413155833.258980739@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237473-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,analog.com:email,huawei.com:email]
X-Rspamd-Queue-Id: 51C5C3F0C6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

commit c354521708175d776d896f8bdae44b18711eccb6 upstream.

Return the error code from regmap_bulk_read() instead of 0 so
that I/O failures are properly propagated.

Fixes: cbbb819837f6 ("iio: dac: ad5770r: Add AD5770R support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/dac/ad5770r.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -323,7 +323,7 @@ static int ad5770r_read_raw(struct iio_d
 				       chan->address,
 				       st->transf_buf, 2);
 		if (ret)
-			return 0;
+			return ret;
 
 		buf16 = st->transf_buf[0] + (st->transf_buf[1] << 8);
 		*val = buf16 >> 2;



