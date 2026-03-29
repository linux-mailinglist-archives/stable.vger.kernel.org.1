Return-Path: <stable+bounces-230872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EITOJHvdyGkorwUAu9opvQ
	(envelope-from <stable+bounces-230872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 10:06:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D93103512FB
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 10:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DEF1302E935
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 08:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B652B2D0605;
	Sun, 29 Mar 2026 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PWpA5CPi"
X-Original-To: stable@vger.kernel.org
Received: from sonic310-23.consmr.mail.ne1.yahoo.com (sonic310-23.consmr.mail.ne1.yahoo.com [66.163.186.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BC724B28
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774771496; cv=none; b=ETxouC+yEHCgrcWeo9jlq+M/dguHqI8C9cDSq64s843zQttSN/Qe1xqa6TAqLpKiM2yq0OesGrWfom6iRoeBaxkoddqKitB2dZDKXfo1sD7lLGxXH3j1WiGDAbSRBNJX1X35VFNkZTiqv+Sh9DyhOXHBGZcOW8YyvqsA0di3s8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774771496; c=relaxed/simple;
	bh=YScehe1vJIcsKixSOZ63sCbEVIMnAUiEXY8jtT16Lto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=BpjTh0EE/6Csm6acB+TRBncOtbOusExDpwlOlhZU7Y8vmwNK0L98b3rGdF5ADxHrFeup45b018Zzl6PplPSIXC1pAvPiNfyW9OPiGItR5F++CJhQOX7B9QWmeXOp7zLrxj1UMr3Yt/KFVR6ZNuDoKhrZhzw1iuVVgtEH9wT41y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PWpA5CPi; arc=none smtp.client-ip=66.163.186.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1774771494; bh=V7Fe5j5YmQNWtMWv+HiettIuHXaF9B12nKExBxT8Hk4=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=PWpA5CPiMp38tjogfRBs9lNEHqoTL8z2STOuBcdqJ0la9vwsA+D4cJGauaV3Rex03FAdY5z0uC36QWLIgn05X/HBkSCERNFgUWwXRQH90CPxlnt0n0qNpUIdNRR7Yamyf8dhKg0ZytB0qKwqo21zUKudVNTafafhzWWogsEKUN6Mug3e6npo5bc35Ey4kPQ6TvIULDv5sd4H+wCuq60KFkUHosvSAN+v0/MggLao+S9sZTr+I2XVJqF1HKOznWbnt1TSHeRgqnwObDCK7htx8o0DlEDhWc4vWlbnhgGCPUa0IoF8vwEkea6BmcX/02G60W5dimPiXnBpisdrs/3keQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1774771494; bh=1+z5vy6gK0wDuf9FPy7rUdU6Y6V/oR7G4MrQTOx6gol=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QIlLYoW/D5XVHBMkv2043zmQjK4h0wEluinv57RhMKlrirsvYqusrLQp2xuqc0n5gr3SMPNQz7wm6LHk0XpLVR5X2qgoKzLD9c1GbUT50nqkKkkpwHixecS2cHQB1nHvNPY15WvN5iEiO0ZsG45qGQ3T0Fdxh6D9EduuGw9jneRROx0xCvgL9Q/H4g3O6XYc/UX+a7dBImZhr78XSQQLPVB7zYttrNFAqc4Aqr/pWUtXSC8e7lD7N5m6zwuAUsqx4pfaRo3eDolD5+M3J0WLn60LTsbza8SUU6/osbT0azon/9kOXhnnA6MnNqW7SXTDh2BrxYhlCgKLVr2YfN60lg==
X-YMail-OSG: wiG56L0VM1lXOrMO7zYN_3EBKtFe6gaNfbn4VxGauCW_4zaeyWLtTSFI_K4VXlU
 EVq8lBrotN1UgbHOZtnlDPQtCZnzwdeQq5fctod.kzCbXw1him0Zzw_LJHlmbyidWFdxuGh2lpbm
 GEqj6M2ivlm91NkusoqEyoxIVifZWYrpMMVkQMkYLnLfPVlFyDCVFTKYzGWflhEcCwMaJE30RdDe
 l2YwVBDRT7LL6V0K40EdXRM8FhDV3s4HydYtec4LFR6sTPGfLB70hayBvC2DcPlZBUh.BlkEfqhg
 tZVQ4eL6MXghcWc3Q3d2xo7Z.uokBG0LmIxtTbbuQSdSgdu950Brs__nd6be_YohY_aQOal_KLgH
 d2n8AemC3GRr0_40zbQ2oU6wypwy.wTxX583wUV_XeCUe3DoQvtrmQVAthC.sNFoag_BGDcaSrLx
 Gzvtbf0qiVPQzHDzlHGRRRobYP0DR5h7SlCiqfHUNUhiEAXT1zV5pb4FsQZoO_39LKKRQyRnzXuS
 acsF6FLJDCI8YYLgMcFnetc7EK8Z4EbYSzdiet9uiao0rq5Qg6d.eei.sqvsy1klaJZfaQp_86cm
 1LM7Yxg8PSpm3mm.mE3awxBGpUUmF9Rm8fUsBPd.cDWxZhjN5HnFYRJOYafM7GS8qWPqF8CwQorL
 11_O3z15NbcRyKFEFkM4vHWjVqqmTvnPCVRZBFTlWM5sYT13hrIs6BaKDnJ9glSyTfxvvDCOx.p_
 k80eS7_8X2QeTOyokKXtxBvgv7RJNwxLtDmXCzL3nKklnqq6JyRK8AUkGoT5OAB5nRlaX2OZIqJu
 pEKB8hoHCvvnh.XkkqDNNjdVL3T8yoYsAxWgvibjD69SqGyMh95pKKKWUmYLV2uYvb8OZiGYh38x
 fEns0XbT.gVObyxX8fTZ1Ut0660FdBmndzuKt9k.bKGucvKw_yqKpcC.juPY4DOsM85jQhQMUsIK
 giY2PsvUjpSSbXnhhu6HGEbeZ_rCfg6GEY5q2pm4d1o_7YVNCh7OmDef.WeyGfhyqrYKoZEuTeAW
 pWzPx2F3kTH.5Ocuis1tl9qSccArVf2U6AftT4.px8d2pGfQ.ZPZfJyyxj3E2aIT.e.9ibPnowRe
 YQ5rWY32ReBbmrVRkhR29oB5pAWHBH9_1eKaNukLYfxSokHfU9IvTeUgl99JZ04K.tR3axRf_V2Q
 nSqtdBlqEqIV9UHZWIGXpKJuzrF2XKKsLUqU1GR_6LhaTAlpbmGkEQBV9b9ydBdXzwy2Bcf98M9.
 BUKFznTlvaTTpokaDDvKqPCsAds3HPYeSYe043X40DEpY93YafL3svwtg648ZnSKBakeRsau9Lj2
 ZrU6N0.reRDtIIYpnclmXLKSuhY75ineJD5rSme.L_LkOiCDWYnY_63.JBSEtmKyxZ9O455osAjM
 4rgtRgrIsmBOe7m77troeCD_2IIUuwx7AIQn0fb8D6rXqwAbHAYtaMMFzggWU0Gsst0yJDjAxWIi
 A8iECGs5bTmfQkGIScICpPEYicR0o1ed5.cUappYW9m8hIqNmIKXEK0LdKam1nb.mOSU7MBqp6Ux
 GnXFtuTaU0vpNCW_4z2rdVj65QDEC6MxeqBIUnCum2WEk6He1RWRc4h.oB4kio19n4YyBwxj3h4I
 0zABzRNZkNm_VNZhfXbFiJjEUJj5h8giBRJ49ExhfbQQS9GcBJnUoxHRsUF_eubvdqNHUCMRuZpq
 KielRewyByp7LO2vzenPi893zm.aBkyO6dUBkFH_BmoX2svPw7rGc_3XoHCrM8aYp4GLwJ7TfSql
 ATgdC5xqahwiLJE9McDL.ZqwFmu64ugmrrLuldui3IzoGt2F1sNo1dypHKoS3bWw4MTQtgByiruv
 lgeFG.NJJ3IpUku1mAHGo3w.RHs9lIXFNpBxxWi7ZkzfYvXn4y.doqz5YO4DaUnbDohsOzO.vm1D
 eV24BnIw7FqC8qBxzCL61lfSujwEqpKLMFCIs1tG0cMh1VLvQ12Tg.8FO5enJxfD19PGZmw6.rgW
 Huwpb5tOMUqUMmlh0mBQTo_Bzmm3LlF6rdbKMovPRUseU70lcCNN1DblylyCFzcUYJ3ByqUTKP19
 emvDcICj68Be9HMLGZuYfAVo_bG.y8p3ixPbSol5zVWmpItFelmqPTnBcdOseO7V6oFz.vx.nsPg
 SgFKlzBX2kliio.pOEnUQfYbil4WKUoeqtl_XDQQyAIBVEPkj0ti86l3XqXRwHG.4PJMFI.H5ju7
 2mKzfWo0LhvOpCnkxQck9WyS8mjbGZ4PxNt73vuSeeDPwnakpkrAF9GTytqbn7714YtFZrU4MjeP
 QPc8E2g9KzgVvp0tSRNcxQwQgUcnQp4.Bvsom
X-Sonic-MF: <abhishek_sts8@yahoo.com>
X-Sonic-ID: f9e14122-7cc6-405d-9192-7017615a970f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sun, 29 Mar 2026 08:04:54 +0000
Received: by hermes--production-sg3-6959968fbd-gj7s8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 704786d9823fd8a8253f68d6c834048e;
          Sun, 29 Mar 2026 07:34:27 +0000 (UTC)
From: Abhishek Kumar <abhishek_sts8@yahoo.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	syzbot+3fc9eecaf97147282c87@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Abhishek Kumar <abhishek_sts8@yahoo.com>
Subject: [PATCH] drm/atomic: fix vblank event leak in complete_signaling()
Date: Sun, 29 Mar 2026 13:04:23 +0530
Message-ID: <20260329073423.8390-1-abhishek_sts8@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260329073423.8390-1-abhishek_sts8.ref@yahoo.com>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,syzkaller.appspotmail.com,vger.kernel.org,yahoo.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230872-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[yahoo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[yahoo.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhishek_sts8@yahoo.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,3fc9eecaf97147282c87];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D93103512FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When prepare_signaling() creates a vblank event via create_vblank_event()
but hits an error before the event is fully initialized (i.e. before
drm_event_reserve_init() sets file_priv or a fence is assigned to
event->base.fence), the subsequent call to complete_signaling() fails to
free the event because its cleanup condition requires at least one of
those fields to be set:

    if (event && (event->base.fence || event->base.file_priv))

This happens when only fence_ptr triggers event creation but a subsequent
allocation failure occurs before the fence is assigned to the event. The
128-byte event object is then orphaned and reported by kmemleak.

Fix this by adding an else-if branch that frees events which have no
completion callback set. Events allocated by
drm_atomic_helper_setup_commit() always have completion set, so checking
for its absence safely identifies events that were allocated by
prepare_signaling() but never fully set up.

Reported-by: syzbot+3fc9eecaf97147282c87@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3fc9eecaf97147282c87
Fixes: 92c715fca907 ("drm/atomic: Fix double free in drm_atomic_state_default_clear")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Kumar <abhishek_sts8@yahoo.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 87de41fb4459..52a6b8436437 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1523,6 +1523,17 @@ static void complete_signaling(struct drm_device *dev,
 		if (event && (event->base.fence || event->base.file_priv)) {
 			drm_event_cancel_free(dev, &event->base);
 			crtc_state->event = NULL;
+		} else if (event && !event->base.completion) {
+			/*
+			 * The event was allocated by prepare_signaling()
+			 * but an error path was hit before the event got
+			 * fully set up (fence or file_priv assigned).
+			 * Events from drm_atomic_helper_setup_commit()
+			 * always have completion set, so checking for its
+			 * absence safely distinguishes our events.
+			 */
+			kfree(event);
+			crtc_state->event = NULL;
 		}
 	}
 
-- 
2.43.0


