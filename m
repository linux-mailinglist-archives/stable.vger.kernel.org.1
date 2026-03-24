Return-Path: <stable+bounces-230219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB1MKCPmwmm/nAQAu9opvQ
	(envelope-from <stable+bounces-230219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:29:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F11031B848
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B883E30BAB7B
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640432E03E4;
	Tue, 24 Mar 2026 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwjKFrZS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17DC2DECBF
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380242; cv=none; b=RP/y6pAQmoZZFN1OR+1GHr9z33ZCSrsKPR9kpowR6P6BgF7bYzD6OE5afHUxDuFWmmowlmwRXSZAfkms6G1+YVmX100vhwt/tjaVDleAMdQYGf1aiWgIv0bREUNilGLPwytp8ngivQq11I9cJmBp3CneWfhVK16k5hmLsGfofrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380242; c=relaxed/simple;
	bh=COYTcvWMtZbNgmReV5I4uKrhM4N+yMIz+yCn9rIkSMk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=hp4McaXBtACSz1oDo+MS3TfpSu+Yq5qgvkve+q6RgrzQYfJFPh1/LfwQKxuMX9pZz9dR7cAj5gG5QLEuIBI2RDuAMr8E5QfmnL0/BWvnTYGh/S8s6PO97dDmUVHzJ9Ztyt/dKdEpXB02MRjmP97Jh3eRY4mIzVfu1olR/CHION4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwjKFrZS; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38c26612508so12723011fa.3
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 12:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774380239; x=1774985039; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=wYMnchnB/TeeKyI/1Ye/NWdU8u0hSMm+QUE/z4pDCe4=;
        b=TwjKFrZSlyUK1FobEQN7cAIIAQNMn3ihFEfsUPWzvMuFbkuiQj6QmLVtJRP/TMyp5u
         6oRwV3NKEyRyi3zwBPA/XFxG+T8k0Xga6BxsQVRP2AVIZdE8aQhByu0q2vmrUKLSOD6e
         mrnyie9HnsmajcEwQHdW25P1TIcvOeB2rYcZE75Semj2UDAcFn6wcCKNvVcW/XYhuGNS
         sOLdVU7QiEm4s4Ig+Bjnza+bv62Bd5gJOEbGt7Y4ItuYSPFxuoN63KEmL6slTGS8e0jf
         BHYztSNeaWhC7RaarcHnKuMlD+sIH1WKd0dBZp4w/En7D2st8jGYyI/8ZnBuSc2vVmJe
         HcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774380239; x=1774985039;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wYMnchnB/TeeKyI/1Ye/NWdU8u0hSMm+QUE/z4pDCe4=;
        b=IHPM/l6uBDWtibrib1hJJ8iAwpDkYfxSk6qaAUZuXrOf+2ru/5c4F2x/YReu/xWuTL
         qNk+gnSY07Rs0SgEbD8ciseiaNNwGRi8eztb9DM1xnJ5ybrMwecgMmXEsr+2yEX1Juo9
         fmncLpJayiwjuw9nNE642HuvGTxkKuZBDpFP78fAuYLHaHOHPyEol9g7ywZKAditU4Q4
         yJeo6NogpldnGLHh9DxtAzDlcHwH3rcvCimDSrpn/B4sUWouzu2GZvvuV5r7WObD/tmc
         yuZagyZURCocVD1DV58BX9zrZxG4ThVfjQslpFMdT0CCSsGUwbOr8KJK5JsMyu6dPD0I
         NaMg==
X-Forwarded-Encrypted: i=1; AJvYcCViDAbDkCHndlJpTxGd9XdiAz0taAOQMxdoYFpFFsIBHV8RDbcLB11dZiU0kNYfkHXGy28wWOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQYZOQjxrComwDxE/O3YJdR5d+jWB0WP5udHuIFTUxPtliYzQ
	VBZ3Ak8QF6lxwZLB6SmTOuMZlu+h0SGRxtxBosjUTCPi09S/gHkRwAaD/TrasC7GWYA=
X-Gm-Gg: ATEYQzwqsiEkYtHrwqulIrU2QxPZ0OE4C/7d8LQ0oa9a0r9ckrsyetdRA/jV8pg4ohD
	TAIdY2Cuawvq7DXoE6rRhnSQGRTwf3u0jeFGNUvBi88pz7bZXn9Uy+D+DEVg68kBSDCFqDj9l4R
	DpHjJwZcMr61pcaHl1qDOtkgE7Ld6eaXPS/Gb8bX4pnMiAc077hfE+By177M2hRKxHtG3Dfx4ux
	zKy9G7IbiQGlz1Cv/0k1y+yrdkVCus2iOsComxi+WzEDl1mrLHRqtd/+3mNRu/bwCHkehhgh8wE
	T3xftOFE9oISpRJn8YvNwR2K3vcKgXCm3uRoWjJ698Gk0uTPLeP4lxqka71bl+XF9+j/8cBbr28
	GlZs//ZXzVYK/o3og/l8i9i0tTZhLqZluOTEt6cTYnLyRIyLmlBX97izifevPMqu/eJ6JkfCH31
	/jsk1tEWEYIGeA16KAa1E=
X-Received: by 2002:a05:651c:4212:b0:38c:4231:91c2 with SMTP id 38308e7fff4ca-38c430c33d1mr1974511fa.10.1774380238610;
        Tue, 24 Mar 2026 12:23:58 -0700 (PDT)
Received: from razdolb ([77.220.204.220])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c34a2db0bsm6416851fa.21.2026.03.24.12.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:23:58 -0700 (PDT)
References: <20250303-b4-rkisp-noncoherent-v4-0-e32e843fb6ef@gmail.com>
 <acFkAPreOFBvoHid@zed>
User-agent: mu4e 1.10.9; emacs 30.2
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Dafna Hirschfeld <dafna@fastmail.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Tomasz Figa
 <tfiga@chromium.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Hans
 Verkuil <hverkuil@xs4all.nl>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Allow non-coherent video capture buffers on
 Rockchip ISP V1
Date: Tue, 24 Mar 2026 22:12:33 +0300
In-reply-to: <acFkAPreOFBvoHid@zed>
Message-ID: <87ecl9f2uv.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[fastmail.com,ideasonboard.com,kernel.org,sntech.de,chromium.org,samsung.com,xs4all.nl,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230219-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikerudenko@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F11031B848
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi, Jacopo!

On 2026-03-23 at 17:03 +01, Jacopo Mondi <jacopo.mondi@ideasonboard.com> wrote:

> Hello
>
> On Mon, Mar 03, 2025 at 02:40:08PM +0300, Mikhail Rudenko wrote:
>> This small series adds support for non-coherent video capture buffers
>> on Rockchip ISP V1. Patch 1 fixes cache management for dmabuf's
>> allocated by dma-contig allocator. Patch 2 allows non-coherent
>> allocations on the rkisp1 capture queue. Some timing measurements are
>> provided in the commit message of patch 2.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>
> I regularly get back to this series everytime I have to reason about
> the caching policies in vb2..
>
> Is there any reason why it didn't get in ?

My impression is that all the review comments were addressed, but these
patches somehow fell through the cracks. I can rebase and post v5 if any
maintainer is interested in picking it up.

>> ---
>> Changes in v4:
>> - rebase to media/next
>> - use `direction` instead of `buf->dma_dir` in dma_sync_sgtable_*
>> - Link to v3: https://lore.kernel.org/r/20250128-b4-rkisp-noncoherent-v3-0-baf39c997d2a@gmail.com
>>
>> Changes in v3:
>> - ignore skip_cache_sync_* flags in vb2_dc_dmabuf_ops_{begin,end}_cpu_access
>> - invalidate/flush kernel mappings as appropriate if they exist
>> - use dma_sync_sgtable_* instead of dma_sync_sg_*
>> - Link to v2: https://lore.kernel.org/r/20250115-b4-rkisp-noncoherent-v2-0-0853e1a24012@gmail.com
>>
>> Changes in v2:
>> - Fix vb2_dc_dmabuf_ops_{begin,end}_cpu_access() for non-coherent buffers.
>> - Add cache management timing information to patch 2 commit message.
>> - Link to v1: https://lore.kernel.org/r/20250102-b4-rkisp-noncoherent-v1-1-bba164f7132c@gmail.com
>>
>> ---
>> Mikhail Rudenko (2):
>>       media: videobuf2: Fix dmabuf cache sync/flush in dma-contig
>>       media: rkisp1: Allow non-coherent video capture buffers
>>
>>  .../media/common/videobuf2/videobuf2-dma-contig.c  | 22 ++++++++++++++++++++++
>>  .../platform/rockchip/rkisp1/rkisp1-capture.c      |  1 +
>>  2 files changed, 23 insertions(+)
>> ---
>> base-commit: b2c4bf0c102084e77ed1b12090d77a76469a6814
>> change-id: 20241231-b4-rkisp-noncoherent-ad6e7c7a68ba
>>
>> Best regards,
>> --
>> Mikhail Rudenko <mike.rudenko@gmail.com>
>>
>>


--
Best regards,
Mikhail Rudenko

