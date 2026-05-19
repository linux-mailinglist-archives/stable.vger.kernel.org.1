Return-Path: <stable+bounces-249665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OrtKZWwDGrdkwUAu9opvQ
	(envelope-from <stable+bounces-249665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:48:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2518B583DCD
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21E5F3049226
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00BD36C0AB;
	Tue, 19 May 2026 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ7nGeIi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DF6366051
	for <stable@vger.kernel.org>; Tue, 19 May 2026 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216525; cv=none; b=uH//D9xgxIn8hFuIdOgnzHXhK2+C4EHx7nK8q/yxSR60LeOePD8HwsKzgyqANj7HL6rGEvU84JBAFRcdExxqkMx4FjmaQseLp+quV0YSMcH+hGO730VnEAou/P5MBy4eHI95GYqeG58RwLQCl5W5eWUzvRRBSYZyDxJg+ChaoMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216525; c=relaxed/simple;
	bh=+ReRBvwgjN62CEzvlVK3O2mCtDVNfcKsS0SOX61dM8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBw+yGFiDRsTLJQnHbHX23kmee57/2AFeHMRgSaOLbdWiR1bxDkAOCK+eWrH7NeZLS8fMYm6M4rC1qkfQkB4qNiQg+IRemcyGJxwEv5ucd7Yg+wrD0bsCz0M+UXtJsnW2JPaJbMuAtnWOKNfTyztFaqJJgb1RQf01uzNWJIGqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ7nGeIi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so47208655e9.2
        for <stable@vger.kernel.org>; Tue, 19 May 2026 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779216522; x=1779821322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEdQj3UnvnU4h8yi+M71QNzdIXPY/4/VW20nlE/VJic=;
        b=AZ7nGeIiPiV11tqr5OiXylB0A+LHisu0sWb4Mp+VfffK6ClvXoUdhbfBy1Yw4E1MDV
         ON7K/36Y/BM+zxnmmOZtuAB5jUiJffFnN5hm7ICSxna3KnVCwznNfPDwWd3JO+FckH6J
         dqt1SYuNmA4+u4T1xv7fri/To6BNgBAmp5whuF7v+HjgtUrLK19A1iz6B5bRChb/xpE3
         M63MEbDbewgGwaJ+fs6Ig0JFtdXcN6UjnZEk0iU35Oaq5xr/BCVg+0edxeGFpIcEliQy
         TfPXSSpBdd9MSIGvGAUy8D/eQwUIIyUyC5bSIAiIZKdBT0BQzPtLRrBhzPi6IbNFDyoE
         5MCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216522; x=1779821322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEdQj3UnvnU4h8yi+M71QNzdIXPY/4/VW20nlE/VJic=;
        b=rCwJ6PY7zPMEnxENlAgUwUqGk+v8+GgvVewpjb2kK89zoNvv9xHR4JJhcGgTB814IM
         dm+LsAV+W7DEDHtw+UJkzCO50UYYiP8zEDJaZ1hrfRTCJGNtBw6wP+/2BFEjc9vtuK2/
         /qL4DKxHoh4zbBECir7Z2Kc6a/HBuf6hDYK8ES56CpY5SE4OY+3+S5gqdNwvRi7pyBo1
         jPocfXBWc8Rvvf7NAkT8im/hq61KEaIuPbpi4+SMXOG4OpTF+NC1MPuTWdPn/EjgIKdL
         a9SJVHCi5jC9XU0g4NCG8KLhh/NsfRlye/bl28mxcYdRXgFouQ5QsoPNMwltj7DvOry7
         5kGg==
X-Forwarded-Encrypted: i=1; AFNElJ/rqCFVira2ecixiDykc3albyEkpk8bRUGuylcvCWfjN2U9f3BPWv87MevgSGlR7Qs/dIyLWfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysq549jeiCzdiV6dQOh7leFy2Ve7pZqwyQ4Y/z4TfjjYi8m5Yd
	bcyGzQXkZMzpbgDMW+2QW5oCsS5b8rjZQmkPcZR6CcBsihvUTUiUUzxX
X-Gm-Gg: Acq92OFp6YiS6PiWvox7gEJSdR3IQFoyopH8q3qxkRvHFxeiq3kpE3px1IKGdJeMMDi
	8wJbFNU/ixRptI9Gyqmk4iUpQ7XlRRTyw0oEOBjT1JVAE2enuoJZbI5IXmayOHiqfa4otO6ayA2
	fhQTFKjGzh8vDCs0qZ849Z0s8su+dcsIahAlX7MTGAtLw+Sfdtre0MgVsBTrKiSfLbW8Q6j0KKq
	jwnlHPfFAg/N2yBqA24j0E6Ll9/4FZszPlX5r6dMbd9TAqL7ZdCq9er4qosiru8QNKsp/fw9/CU
	ogyKfNrt5QJBZIb7A0n45YOgEzfto5bhU+72Wv2fu64ul9lIStyBlGMiP18z98QL+ZL9kcThGGy
	UoNGLRKoyopmVe1zyt5M1JKUk5RoMlMSuyPctyrkKvuOm3D91JpuVsDn/k7WZ0eEdTa2IzCmJvA
	78Ny9x5jhCRJUQlMmuCggVO5i4Neb0bnfCehcLb90p1IRx8UQIQHd4cz6zSZr7yBhJoT60WjWvx
	sKdvoaLBfZ3
X-Received: by 2002:a05:6000:2902:b0:43f:ea25:20ff with SMTP id ffacd0b85a97d-45e5c594d5dmr32513532f8f.29.1779216522437;
        Tue, 19 May 2026 11:48:42 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6449sm47420197f8f.37.2026.05.19.11.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:48:42 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v4] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
Date: Tue, 19 May 2026 14:48:21 -0400
Message-ID: <20260519184821.18925-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519042017.29564-1-meatuni001@gmail.com>
References: <20260519042017.29564-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-249665-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2518B583DCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr * and
immediately dereferences hdr->addr and hdr->ctrl without first
validating that skb->len is large enough to hold the header. A
remote device can send a crafted short RFCOMM frame over L2CAP to
trigger an out-of-bounds read before any session state is checked.

The FCS trimming code that follows compounds the problem:

        skb->len--; skb->tail--;

If skb->len is already zero the decrement wraps to UINT_MAX, causing
skb_tail_pointer() to return a pointer far outside the skb and
producing a second out-of-bounds read when the FCS byte is consumed.

Replace the open-coded cast with skb_pull_data() which validates
skb->len against sizeof(*hdr) and advances skb->data atomically.
Save the original skb->data as frame_start before the pull so that
__check_fcs() receives the header bytes as required by the RFCOMM
FCS specification. Guard against a missing FCS byte with an explicit
skb->len < 1 check. Replace the unsafe skb->tail decrement and
skb_tail_pointer() call with a direct end-of-data index and skb_trim().

Note: SeungJu Cheon posted a related patch that adds equivalent
length checks inside the individual MCC sub-handlers
(rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
rfcomm_recv_mcc). That fix and this one are complementary and
independent; neither subsumes the other.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

---
v4:
 - Keep no-session comment and add blank line after header/len guard
v3:
 - Replace open-coded cast with skb_pull_data() per Luiz's review
 - Save frame_start before skb_pull_data(); pass it to __check_fcs()
   to preserve correct FCS validation over the header bytes
 - Replace skb->tail decrement with skb_trim() per Luiz's review
v2:
 - Fix GitLint B3: replace tab with spaces in commit body
 - Add Cc: stable@vger.kernel.org
---
 net/bluetooth/rfcomm/core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337..e78ce11fa 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1741,7 +1741,8 @@ static int rfcomm_recv_data(struct rfcomm_session *s, u8 dlci, int pf, struct sk
 static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 						struct sk_buff *skb)
 {
-	struct rfcomm_hdr *hdr = (void *) skb->data;
+	struct rfcomm_hdr *hdr;
+	u8 *frame_start;
 	u8 type, dlci, fcs;
 
 	if (!s) {
@@ -1750,14 +1751,21 @@ static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 		return s;
 	}
 
+	frame_start = skb->data;
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr || skb->len < 1) {
+		kfree_skb(skb);
+		return s;
+	}
+
 	dlci = __get_dlci(hdr->addr);
 	type = __get_type(hdr->ctrl);
 
 	/* Trim FCS */
-	skb->len--; skb->tail--;
-	fcs = *(u8 *)skb_tail_pointer(skb);
+	fcs = skb->data[skb->len - 1];
+	skb_trim(skb, skb->len - 1);
 
-	if (__check_fcs(skb->data, type, fcs)) {
+	if (__check_fcs(frame_start, type, fcs)) {
 		BT_ERR("bad checksum in packet");
 		kfree_skb(skb);
 		return s;
-- 
2.54.0


