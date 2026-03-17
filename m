Return-Path: <stable+bounces-226000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCJyAGhSuWnYAgIAu9opvQ
	(envelope-from <stable+bounces-226000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:08:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B41212AA828
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03C2E303ED84
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984CD3C1413;
	Tue, 17 Mar 2026 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ht+3US4g"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE7D3AA51F
	for <Stable@vger.kernel.org>; Tue, 17 Mar 2026 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752726; cv=none; b=JN2NfWdIzNRciyWKyrnIIVA/77KhpiKHZSAogrsWmIgzbtNr6WX0y3QhpHxpsITgFBQsSZ8f/kx5J/4BB96Ds2Slwf63Zo2Yc54wU+CYp4uD6gSYpkUjXzi6H7WijkcEIvWiYdkMKer0G4PW2eWUL08qjdw2O3sbE+mexa3GAmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752726; c=relaxed/simple;
	bh=QQoN1d2ECBK3+g3UomEpa9pGoyojwA+PDy2BD4p6c9k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eJpNsZ8NaMDWNZG8tJIgijiXoGcpa/uKEGziDuSFSJejzbF0lA59MKGbY2hi2wUU/8BQooTOHNrqBbpSKVnlAoAmahNWRhG8GcOkqHtbdgHuZvcd4isVp9xmZgrCrnpr9+cbZgmaFz7fKF5oodgPJr3D3GPizO5UQmBAeRHYSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ht+3US4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99159C4CEF7;
	Tue, 17 Mar 2026 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773752726;
	bh=QQoN1d2ECBK3+g3UomEpa9pGoyojwA+PDy2BD4p6c9k=;
	h=Subject:To:Cc:From:Date:From;
	b=Ht+3US4gEpgW3yHRET5aCuNjKXrC1iWus0R7IlEJZpE+EFqBwvnHQHV+I9dhqQJU7
	 h0ln8jspBE+GxYHDvjMa61FF49KkTQwJNLp7hJbhcSR5IiOJajfnQYsb5L1kB6roEr
	 ltXKrteexOFfg52/sxm3F70MTT/zlKGHhUTkuGbQ=
Subject: FAILED: patch "[PATCH] iio: light: bh1780: fix PM runtime leak on error path" failed to apply to 6.6-stable tree
To: antoniu.miclaus@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,linusw@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 14:05:07 +0100
Message-ID: <2026031707-gravy-outlying-83e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226000-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gregkh:email,huawei.com:email]
X-Rspamd-Queue-Id: B41212AA828
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x dd72e6c3cdea05cad24e99710939086f7a113fb5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031707-gravy-outlying-83e6@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dd72e6c3cdea05cad24e99710939086f7a113fb5 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Fri, 30 Jan 2026 13:30:20 +0200
Subject: [PATCH] iio: light: bh1780: fix PM runtime leak on error path

Move pm_runtime_put_autosuspend() before the error check to ensure
the PM runtime reference count is always decremented after
pm_runtime_get_sync(), regardless of whether the read operation
succeeds or fails.

Fixes: 1f0477f18306 ("iio: light: new driver for the ROHM BH1780")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index 5d3c6d5276ba..a740d1f992a8 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -109,9 +109,9 @@ static int bh1780_read_raw(struct iio_dev *indio_dev,
 		case IIO_LIGHT:
 			pm_runtime_get_sync(&bh1780->client->dev);
 			value = bh1780_read_word(bh1780, BH1780_REG_DLOW);
+			pm_runtime_put_autosuspend(&bh1780->client->dev);
 			if (value < 0)
 				return value;
-			pm_runtime_put_autosuspend(&bh1780->client->dev);
 			*val = value;
 
 			return IIO_VAL_INT;


