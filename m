Return-Path: <stable+bounces-238278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJJPE/Kl4GkEkgAAu9opvQ
	(envelope-from <stable+bounces-238278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:03:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A1E40BF65
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8957A3020843
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C88634DCC7;
	Thu, 16 Apr 2026 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHNGJ4MA"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D7E31E832
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330189; cv=pass; b=GIzL/r96M31bj7dVXK6lTC1kDDo/P/1uEExTN1WGx9nI2Gk3/fVV6hDX7u8h5K81SrHasrug3c4vwfL4HRM08QBbcO1vDoajCNSkrONLT0z1lUFi98L57KbwYPeKJTiW512ZaPkDOQnH6iCJ0dPeghlvm09yQpeBmd79zC8FTnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330189; c=relaxed/simple;
	bh=YvvNRt8N44zcNbaa7IRqWXoi4C5QZ8FmEaaZXFM/OYw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=G4Zo3UeSICyh+KYdfWPdwueNquyaTBPRGyIE4YWcBZZ+5RoFB93EugPvTN6CD8U8xjpzS2lTVqACZyXiXG/tIboVYqrKfmy0gdfrbsdz8HQhlzblZOIer3XmVLQxpCxY2otp0fo7Qk/TmvpH5iMyd8tuHxk3JGy0DSnLQH+O2Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHNGJ4MA; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2d832f2f44cso5384937eec.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 02:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776330187; cv=none;
        d=google.com; s=arc-20240605;
        b=UFFZU7cSeXm2/fmLQBztI3wLnLSUmtkfT5PySb44RE5YkcjxUTR4omB9qy8STzTVCB
         /ZikQWhZBJV29t41vDEfAEVvd20PJltUd2nvEiwrr8Xt/SUCHcvIq0RGH4a5o3ZBUg56
         HXhq2XKjK0f8tjo/stUukd52PPiX1ixxhDdqHbPVuU5i0TmHZo5FdDpfLplZePM54dWL
         C7yMZsMiljbOxCe/vQhkCbBy0zFn2XXgzkxyeRvdgWl+pAAGGAw6lzFdES5sJq+PDbUe
         OCzvoEOVaFX8AJQOlfJrAPAGqOAchSLjZ4U5i3eEgDpI4Cwtz9ES46qkSP26CKoZhFEN
         h8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=YvvNRt8N44zcNbaa7IRqWXoi4C5QZ8FmEaaZXFM/OYw=;
        fh=pEvcMzxk490MIWkCVLc+pCHCny4PgRe8gl+6oq0rH9c=;
        b=O4u14XnAyLIZLhoSZukxxVQ/abEbd3c/5uig0Gn/wN2U8aLNi1hwk4n55uNc+WV/0a
         jsg8TW44pMIS0SMhoyponBbuX1YyocMt4okKnslR61NcyWidtOzV4gPDyvQ+8in7kSx+
         r582gPb57j0zRcOc5QNFSCbsYr8Cmkf3O6o8+SOTj+oKQbPw5t/8hNxpTiY/s0VVyeVS
         GPqor8oQvhC+iXAzSZN7y/0Z9NekvcFCdlhhjiWdNW3WLMEOpYcJf7QlgocFjwGVal8/
         RRqkzXsNpl6VHuEbnLJZoHisEUyHOnNXNqrqOfG81fDHu6NyhKAzwHveRtqwd31E8lmI
         cwnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776330187; x=1776934987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YvvNRt8N44zcNbaa7IRqWXoi4C5QZ8FmEaaZXFM/OYw=;
        b=bHNGJ4MAobeVkvI8QKZfhRPNM8Md+smviMi6qf83oZnnsl91sLyuQCdvWhuynv7RI7
         abVgG+9opD3zaei/pvjzkOmkyPOXYygy3bvWfeSnWvlgHkrgwtccxUoUM6TTImTeCf6r
         zIh7GH5x5T6wJNzzre7sZxuEp3sga/t+seV5EG0KQWwOU4qhA3SQ15pJZHVaj84AExdn
         lbuLFVIVg3lzuh3y/7kTv0Sypv9vbUG1RdQt9jsDRzai/l3OPONe6A4kdoWrbdoZAWng
         p5vYTgD/76dy0Whf4wNZOZWHWCV4rWq2ZLpG8zvjQRLEeg79QPEocIjUwOusWOVUuoRp
         uriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776330187; x=1776934987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvvNRt8N44zcNbaa7IRqWXoi4C5QZ8FmEaaZXFM/OYw=;
        b=a1kfuf+i/rhqrDeyAfu9kbsSDqHYT0l8DGqYaj7iw6JdlhHbPEF7y8OS53QBMZ7+jL
         EFGwTB65SA31Nbu/7BLsAnwTHChJSubhkSlOtVOBQkrtxRLi0gPNcL03DgCIgeoOFdZa
         vq0OscKaAOHnD0jKKoxAwTbgZAnGL+DOCpyzwiXq7vlNhAAGY/XZdeyBTEPZrI7PnJrV
         y/dYdpiwMvHwvFMnkQR0W+/CNrwyg/+m7yGb8Jb2qw8C/M7+cXVJM2vGcgzWPF+PWlEA
         gP/xFeJUthNhPsCS9XQUHEJeNc/lQB/AJPT9OFv6gf2g0/+Ht6zGhQebHq1dPH2pwAea
         1QrA==
X-Forwarded-Encrypted: i=1; AFNElJ/2ZSa9a7SO3CDN2hqouX3le09ZjStGiReihr/4Zl6pwNRRprbSBThC+pAM57D05QDMMiWdTcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfclpRsCHJtB01bADC3TJQgIqKDqzAhTGJYNUqt8AsscWcDhsA
	tekP2qyDXR7Ryu9lLEx6DxpFrE7A0XGxE/VMtwwQoLphNoeAysin4zHnkNXgw8Ey9ASat13GZ0f
	0MCOSvFAlZRsZu59DGmwVxlV9naEuw6w=
X-Gm-Gg: AeBDiet4FGHY/7fjlfLNiwWjX+J9HS01Igwt75sFQFuYOlTydjfaTMe4ad8G6iQOFLk
	w83/i2MoqRcFPRD4lRNXvOVO9EeAxbIVYbSbXXQoE/chbt+5bgO0FUd3XEIHe7tOqFA7iBPzngs
	pf56X8QIEsFeEkVN6lHeOGBoFgBfgT2EkTvmJll6395QeeNoJMrP37mxgFvY4op+X3bEG8gPlR5
	DNVw4QktP/UkWMik5q6Gu90EK6O/d4p+8PfrkFmeZ9w2ph6XNpDJPwPgcwngw6zw193vBuNC//p
	voh9P7870VJIK6Ypc7M=
X-Received: by 2002:a05:7300:6d05:b0:2da:44ac:6d17 with SMTP id
 5a478bee46e88-2da44ac73d7mr8430546eec.17.1776330186461; Thu, 16 Apr 2026
 02:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sheroz Juraev <goodmartiandev@gmail.com>
Date: Thu, 16 Apr 2026 14:02:53 +0500
X-Gm-Features: AQROBzCSZziCMqVSc-4LKPugtGbhRz9-Yhx2NybwpvyU40Cu7MOJ0VRdGoQO-n4
Message-ID: <CADPJysyMn_07rb+9b3SgR3xTn+uicSoRp5FMB=oeKNbABtZ5gg@mail.gmail.com>
Subject: RE: [PATCH wireless v2] wifi: iwlwifi: mld: stop TX during firmware restart
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[unwrap.rs:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:query timed out];
	TAGGED_FROM(0.00)[bounces-238278-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[goodmartiandev@gmail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_THREE(0.00)[4];
	RSPAMD_EMAILBL_FAIL(0.00)[20260405054145.1064152-3-cole.unwrap.rs:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3A1E40BF65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Miri,

Thanks for the quick review. Let me address your points inline:

> Why is there a leak if we freeing the SKBs after we failed?

You're right, "leak" is not the precise term =E2=80=94 the skbs are freed
after iwl_trans_tx() returns -EIO. The issue is allocation churn:
mac80211 keeps scheduling TX via wake_tx_queue, so
iwl_mld_tx_from_txq() keeps dequeuing new frames, passing them to
the dead firmware, getting -EIO, and freeing them =E2=80=94 in a tight loop
for the entire duration of the firmware restart. The /proc/allocinfo
numbers I cited (10.8 GiB / 16.5M allocations) reflect cumulative
allocations during that window, not a persistent leak.

The practical impact is CPU waste (softirq spinning on
alloc-send-fail-free) and slab fragmentation from millions of rapid
kmalloc/kfree cycles, which can cause memory pressure on systems
with limited RAM. Adding the in_hw_restart guard eliminates this
churn entirely =E2=80=94 same as the existing guard in the RX path.

> This was fixed by
> https://patchwork.kernel.org/project/linux-wireless/patch/
> 20260405054145.1064152-3-cole@unwrap.rs/

Thank you for pointing this out. Cole's patch fixes the TSO
segmentation explosion when AMSDU is disabled (max_tid_amsdu_len =3D=3D 1
causing num_subframes =3D=3D 0 =E2=86=92 32000 tiny segments). That's a
different code path from what I observed =E2=80=94 my issue was the TX
dequeue loop running against dead firmware during restart, which
happens regardless of TSO/AMSDU state.

That said, the TSO segmentation explosion he fixed may explain
why the system freeze was so severe with TSO enabled =E2=80=94 both bugs
could have been compounding. The in_hw_restart guard in my patch
would prevent both scenarios by stopping TX entirely before we
ever reach the TSO segmentation code.

> Not sure I understand if you have a new FW or not?

The ucode version string is the same: 101.6e695a70.0
(bz-b0-fm-c0-c101.ucode). But the linux-firmware package snapshot
changed =E2=80=94 I was on an older nixpkgs snapshot when on kernel 6.19.5
(early March), and now I'm on linux-firmware-20260309. Since the
version string embedded in the ucode file is the same, the firmware
binary itself likely did not change. The NMI_INTERRUPT_UNKNOWN
crashes stopping may just be coincidental (different uptime,
different traffic patterns, or some other system-level change).

I don't have the old linux-firmware snapshot to do a binary diff,
so I can't say with certainty whether the firmware binary changed.
If you have a way to check internally whether there were firmware
fixes for Bz-series between, say, February and March 2026 releases,
that would clarify things.

Either way, the code path in iwl_mld_tx_from_txq() remains
unguarded =E2=80=94 any firmware crash under TX load will hit the same
alloc churn. The RX path and TXQ allocation worker both check
in_hw_restart; the TX dequeue path should too.

Thanks,
Sheroz

