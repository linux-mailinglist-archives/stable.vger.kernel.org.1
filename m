Return-Path: <stable+bounces-245213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMMYHOvYAWpMlQEAu9opvQ
	(envelope-from <stable+bounces-245213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:26:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB4650ED85
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A959E307FB20
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824D33E5EC0;
	Mon, 11 May 2026 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="WXJTYhVt"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1562433ADB3
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505624; cv=none; b=XZcjH23/fn4SQ8BiGUjUEKzmKCM4+wnz4lhq21HXlrAzsuoCIDiNsSG6X+UFXJhjNBYXk2LHohxueGwXqQmMfkoCwP8WefXEpW3UIJYTIEDYg+23As/KAeNCvbtrLOFpaIKZxGhfmy7VVzIhRY/E49PIDwJSP1zMowfggS2ybiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505624; c=relaxed/simple;
	bh=TmlF73mBAE8nFK7SrXa/lCumDBYZ/TfJZ+mvM60yTxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9M1WZmAvfFJD1nRuGhCxYm3sfv3ucME5NHos0QfJOxD6/XQPgAsb07d5UR1PYWwiz4ol+ZMLiPYU4nj5TEaB62H1UM5oJKYngzJ3qrhBaR89u2yIk1XKU7D+4DsuEMl5RbwtbOsYKGUfzXGXr/8HjZkHmHUx3aa0hnF9W3MXTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=WXJTYhVt; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4303eb92930so3018520fac.3
        for <stable@vger.kernel.org>; Mon, 11 May 2026 06:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778505622; x=1779110422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZiY94xRt+IuZ0M/273x48bBifax+x2ozD/E/r9Um4w=;
        b=WXJTYhVtsqhWaLf9G98USyPifx+rNUb6+oDTddD4mJbDtehCdHEtU7mr7TpBNiteKR
         zv2oT/tUN22GYgMWATZXS6us0RaXSMrP6z4uH0k58+6fy3X8Gi5JhNmIeDTjymBgWtWa
         fsTZGBOwNoS8Gff/M8UL81nsuJB1t/gN7qI0ci7/n7BcqwUKVyLxXaWPdOT51mxLuK7E
         feYvi9A9mGC9cAP8QaXDxRFAbTxVc0kxvSOxvnzi1W9U+0aa0ZXTFgtcNx9ScmIScUxa
         jRkrKn6cHTwGXFHd4IHs4kxdzMh9sI/l/OeTHsQF2UPbadcEMtDUXw1idCBK9Fwiew41
         Dteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505622; x=1779110422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ZiY94xRt+IuZ0M/273x48bBifax+x2ozD/E/r9Um4w=;
        b=tOE8EWrwH7ElMO3Cc2ZWUgKCaBzcgS2ZEg28PXqGsKxIrz3ui0Es2q3fEtmesuUjLb
         cAIVnFsZAzOOTAUqEp+gSvRvTInMGiqY3Swof51yGQRMUu5cjC1xtnICUf4wSXUT6yt6
         Cqq9IDgMVbdS9Q6M0B28uw8UUXENUbYmBgElOSF2oFMB/D1ymD+YqRleDy5j3E90MUrz
         sqW4QsXr8a1arkW0WP2g1zusI2xnpeFH5efwnk3NASkRxcnvX8MlO/dulp67MyCr+3/d
         jYCqQZjzyNjkm9O52YDOvHV0c+3ahqeVOBk9XfKJi7ALExZthwpA2EnIZg90KhYILbWA
         0GxA==
X-Forwarded-Encrypted: i=1; AFNElJ/XGoKCKDw5FdyBbTIgJkBiHUwgwx7IJ87H7WX4W1Cle530IZjHc8d3kL5dM7I2ytEK6jjfS6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZ5akPJqD35DHmLVzKTv1YVgU/vhSzzkVRvwcVh10ZJDQ4BbK
	NIruCIi8Pcf90NFapqLNVYNkkRlB4bbPA7yPY/ETAxzbJkoQwAE3rI0ZVtfaZA600jo=
X-Gm-Gg: Acq92OFmk/Xf2IbCEmVLKzwGsKPX61DdfIBmxQLYfYUyzIKmk2FJBiM4RFYH2nZ8EWQ
	66+OcDxn7CahFVpc4hAaYUQWG0HwAaYzYgmg/4Xz3dSlcoPPiHMObCpjZEQdrDIsHQnk4Gp8tQy
	PjHx5SoT3Jx5rKy2Tpb1VlIMAX7bSozFth2BzM2smmKCxP97aS66qrRBPfdyyKtpaT3xRjXAzS3
	TUl09uaCN0n7HNQhEK6isC4lwHo0EgmND5VQ4fRb48HOhxeds37T0a4DD2LqiHbGrmNeVDKu0/v
	fDfCK/a9psfVfdZffJ3zqIE6JuiW48xm9kh1LoOTpSVtKXkPFXaXN5oANXPVhd4aD61YWkycrxk
	JxWmk9Jdry1+nRSnMwiJQWwqvnTRiRce/jagAtSNcvOFX1nkAu5bBaqty0s4zsef+lGp4i1gV4R
	nXHrd1svptPQ8SxquJWv0b342oRilhV2k8hJso3YLMzOpTpwC5qvRG6f+ldcEt4Vfl5uwQbOxRB
	yg=
X-Received: by 2002:a05:6871:72b:b0:430:3591:26ce with SMTP id 586e51a60fabf-43556ebb0c9mr7944911fac.24.1778505621892;
        Mon, 11 May 2026 06:20:21 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8478:44:4948:b0d3])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-435573e6ec9sm10085171fac.15.2026.05.11.06.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 06:20:21 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Li Xiao <252270051@hdu.edu.cn>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 5.10.y v3 4/4] ipmi:ssif: NULL thread on error
Date: Mon, 11 May 2026 08:19:42 -0500
Message-ID: <20260511132012.1831026-5-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132012.1831026-1-corey@minyard.net>
References: <20260509122858.ae87f8133ecd.re-ipmi-ssif-cleanup-5.15@kernel.org>
 <20260511132012.1831026-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CBB4650ED85
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245213-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,minyard.net:email,minyard.net:mid,minyard.net:dkim]
X-Rspamd-Action: no action

Cleanup code was checking the thread for NULL, but it was possibly
a PTR_ERR() in one spot.

Spotted with static analysis.

Link: https://sourceforge.net/p/openipmi/mailman/message/59324676/
Fixes: 75c486cb1bca ("ipmi:ssif: Clean up kthread on errors")
Cc: <stable@vger.kernel.org> # 91eb7ec72612: ipmi:ssif: Remove unnecessary indention
Cc: stable@vger.kernel.org
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 drivers/char/ipmi/ipmi_ssif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index c973c0d92319..43c4863e7b03 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1891,6 +1891,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 					"kssif%4.4x", thread_num);
 	if (IS_ERR(ssif_info->thread)) {
 		rv = PTR_ERR(ssif_info->thread);
+		ssif_info->thread = NULL;
 		dev_notice(&ssif_info->client->dev,
 			   "Could not start kernel thread: error %d\n",
 			   rv);
-- 
2.43.0


