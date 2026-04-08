Return-Path: <stable+bounces-234175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ/mACec1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:19:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 857823C069F
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACAF7304E0FA
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ED2385513;
	Wed,  8 Apr 2026 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WsLOEiQl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF91B67E;
	Wed,  8 Apr 2026 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672177; cv=none; b=LAjaoUSiO/zWnENaMkC1XXe99vPMc2kl+1e8IevwCrTFAON2jgsmKCa5rvARu6yQ5R/NTVBipZDZSsA7xOV6Nz0irmRrQZ4YUWKWQdYtjrR3CfyXDUirtjM3EOl55+c4ncnoAV+EH5mQExCp9fmxRqTf+PiT/kxp7UU3lbgbgtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672177; c=relaxed/simple;
	bh=KJBkDsoqkJ8CgFCbkbrx3M16Ha2+mVbn2BhT4TFoDYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnvl9Iw/zOEgZNQdHRRgu14pXg3LF5A+yAWBJ9bPUIkMQBySb8Yop4ABgbJ3PESJOpbzNw49C9G6YaJfwf2/bN85dKKYI+8/L0wI8yHTkZC4My2qrI7am/ZFWs2DYRBRVpBjVKP+h9Hy9csgGSwInwBXj8FcwPf1A8Bsh2GIEDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WsLOEiQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61005C19421;
	Wed,  8 Apr 2026 18:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672177;
	bh=KJBkDsoqkJ8CgFCbkbrx3M16Ha2+mVbn2BhT4TFoDYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WsLOEiQlE4abLfdesMP43HyYGiGuETDEUkB7/7yApKFCnDHhisfDtrZdyTZAEn+E6
	 PY4CBtqzjmHLtaQ96ri7YTQ3OCS0QPpNlToRYiVXIB3muu9wuekuxKknVnIF9944AV
	 Gb/ga4ftcnRSxcRlgOBl2/c3TyVGEA0Rr4PZHps4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 219/312] iio: dac: ad5770r: fix error return in ad5770r_read_raw()
Date: Wed,  8 Apr 2026 20:02:16 +0200
Message-ID: <20260408175941.937964259@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234175-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,analog.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 857823C069F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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



