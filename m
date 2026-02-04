Return-Path: <stable+bounces-213626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO3eNLxgg2mfmAMAu9opvQ
	(envelope-from <stable+bounces-213626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:07:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EA0E7F45
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5A66318B02B
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1089E4219F4;
	Wed,  4 Feb 2026 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sL7onBaf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F0241C2FC;
	Wed,  4 Feb 2026 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216960; cv=none; b=omiHdxyhu9jGEnOZRLtdLL/nxOkFQMwSzNZdS6IM+iC7govtvwHS5gMfmnkHx3yJOzQwFaO6cUnX95xACEsUHU7JyJnc1FNeKU7jDAvUKMUSZdinfDa3WhuvOw2N6haH8Mw62EeebFBCyPqGs1FS8gl7CyRTUF5+nF5JxoHOpRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216960; c=relaxed/simple;
	bh=BgurllEU5gmHw5fBb7DxPWcpFUAvC8iLVoRDowgmoH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRS0dWrqs7K1MrABev41a9wcZDg01hQTg+D+XaBk4T736QSzqcpdUS8RsW2ddNnJlKBAUg8ba7OTFoFQriMGu+TnrZqpX7jxmaEPbhkMXusMYZTVGDq95DPAZoUnqke6y5f3uJYG2JXZFECs0NEUS5qkvhQysJ2DsKQozPCirX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sL7onBaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB60C4CEF7;
	Wed,  4 Feb 2026 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216960;
	bh=BgurllEU5gmHw5fBb7DxPWcpFUAvC8iLVoRDowgmoH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sL7onBafaIfd+56wFWoa3RB6K/eOPM8mtXYrbXUn7atQ35ZimJtHRS0udmTxrwnMc
	 DfW9ojnvQ2ERY7iZ/8fUXTtYXNektoA9+d6y5Rvki9hZQiJdNdbFIEsiwdBqfP8rVI
	 P6vIrnSA0sKzN/1nRiqL4T4QmuBt+9LLuj2+nTKw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5.15 083/206] w1: fix redundant counter decrement in w1_attach_slave_device()
Date: Wed,  4 Feb 2026 15:38:34 +0100
Message-ID: <20260204143901.201330163@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213626-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 47EA0E7F45
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

commit cc8f92e41eb76f450f05234fef2054afc3633100 upstream.

In w1_attach_slave_device(), if __w1_attach_slave_device() fails,
put_device() -> w1_slave_release() is called to do the cleanup job.
In w1_slave_release(), sl->family->refcnt and sl->master->slave_count
have already been decremented. There is no need to decrement twice
in w1_attach_slave_device().

Fixes: 2c927c0c73fd ("w1: Fix slave count on 1-Wire bus (resend)")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Link: https://patch.msgid.link/20251218111414.564403-1-lihaoxiang@isrc.iscas.ac.cn
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/w1/w1.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -767,8 +767,6 @@ int w1_attach_slave_device(struct w1_mas
 	if (err < 0) {
 		dev_err(&dev->dev, "%s: Attaching %s failed.\n", __func__,
 			 sl->name);
-		dev->slave_count--;
-		w1_family_put(sl->family);
 		atomic_dec(&sl->master->refcnt);
 		kfree(sl);
 		return err;



