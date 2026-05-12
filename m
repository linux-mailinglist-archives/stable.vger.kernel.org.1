Return-Path: <stable+bounces-245380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CRoDSKMAmrzuAEAu9opvQ
	(envelope-from <stable+bounces-245380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 04:10:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0F7518BA3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 04:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18518304972E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184822F6918;
	Tue, 12 May 2026 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNl4YGN8"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF12848BE
	for <stable@vger.kernel.org>; Tue, 12 May 2026 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551692; cv=pass; b=ZssYSMX8tzzC0pcPtLlf+OLIIMHibpAgHRy6zGtrSNcFloXK0AvaZuMmm81hFM5hy7gdbMqySS+m70HDUEoaJ2+1AH3JbecM1QgUlvv0P/uPcKknSIkolRPBjuJ56RL4VGZagtx9h87ZLpqZDqwa7uKwkT2MhqABz6UyHh66jrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551692; c=relaxed/simple;
	bh=tBWsdUmqpMA5QmxhdhkcdrvEGx/LMSt531O8iAp6EJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEceTPyYbEV9KDdR8qmaj82XqDiwIcKVIrjUjTa4gnFE9crr2jg5+7c2uE179l+Jht8B3/T/rSJnSP3RqfsnCKagIwx4vyTVtXWqs8dg0vtNrXDfj0yV2UTZH9YT/svVUr0aUF0d5WU3tp+RR1YKAbgX5MipI+4zWyqTqzupJ+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNl4YGN8; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bd6f65c781so45011967b3.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 19:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778551690; cv=none;
        d=google.com; s=arc-20240605;
        b=M2qo7oItLWoFYeTzAdwqOiuqBYalRU0eB2cLpdcCUKX+xGBfpUplePlP+wM+KxlnS3
         WFN8zj37dMl8darXXfk7oMZ4UgTkRGIVpYEHq/Fkl90q02tBcthC1VephkV9HEGB0Jbk
         XYg0BBE6kUva/NOlalovHKe7ztNbGXGqPFsKpr/7CDMHYtsCa4BUNlTaLgswMVS++OP0
         KRMlpJs1WGC6b8qOCNrtKDTbwJ9xnj+ZoiJIwm8Wejxj5BIDAqj5O7ufpe4MeZQjsNd6
         Q85hD17T67IDON8i0xKBih/n6hAtn/X/LvcyLKLxhdmH7d7xN/Jztr1NX2AK8p6e8c5J
         4V+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=77FISKu6p2sK0Ty+tC1DOLiHarz8B8kEbkXuaAXpQYA=;
        fh=2gEgIsl7vcGERrj008sTCakMzfpH3IIbk4TGFKOdys0=;
        b=AfaTPgJFyKfp18bEAaTFNLMMwEso8+602U38SmS+5X1wfQYeHVFWfwXl6VkNcZEYQB
         twQB79QRexbwhQM5ZFDCd1X/A8ihtSY7PTp5O4NMpoxAvFV0IDoGywL6mNYkMiMByWIt
         2EHLFilecCYPDHizUQ66xgzB36YcgsWH4nj5tiSaa7lUEBcGywdjtpjxsHhBKKJpMimH
         mVgs+dy9NKfOzWtFn09UfhhgmYF0GqNdXm1xUYUvsB3Jok6JCwXAXoIIc2JZRNQpSX4k
         Fh33/TppQtCS0Jg0Px1Pq0FFa4jgfavOyhV2aQ/NAfAspDlcfXMR8hi/Oor8iCR+Pd9n
         /i3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778551690; x=1779156490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77FISKu6p2sK0Ty+tC1DOLiHarz8B8kEbkXuaAXpQYA=;
        b=JNl4YGN80X36RcaN0icDRKssQUFqHbRH8ZAX77NrcjY8pClXvtKxomPGt1soz/xofv
         Esx/Vh5+iW9vfzEu0DoO6ugcyqxbmvPlMLSF1g1fcLcBnvfIOaNi1nC114JieTZ3atVE
         2pxYQ76rly9AXgnDFNdObzkhPmRK3qEuPs+ptKPTkUyCHxEP5UJce3yPr8Nfdu3hvtBE
         B4rHeeP6ZFBoF6JWqMllW0YdkcnWDm4KW4oEH9oy1JPhVVJPlGj4ttF1S1zDiYazYHS8
         qN6ij8En+FdQmgvMaWaUR3GGz01ycWDrZp21F9dmhAvdN9XmVQSud2l2/qdlsn0Xchiu
         wEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778551690; x=1779156490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=77FISKu6p2sK0Ty+tC1DOLiHarz8B8kEbkXuaAXpQYA=;
        b=akkKefRpndEHnJNUSUBA91vUWW/Si5Tl9lkht0r9betkfRZQCUQHD0qRwYnLDmI+kR
         0fkPMC1HHY02w8MNdiyXpzBuUtQ1KiE19cyfveStvHoFY5SfNXwpTwmEb4hJgZ1/3/qz
         z1s5NfThbm/mtVNxkl+8wwXOAP1fuVBi01ppXuSlsRltMoU0K8FdI6wU4N9caDOLKSwW
         nVF6bIHdDNgOKYverhzZgjAJ8zL7shz+AOLVtLSzkC7oTh6pcA1ZiX7BFW1CmM+FokPg
         4vofU4e3JxEFLpbMHjuhV8TJONM1tKa2PpA31BxcftvdE40X+lc0x21t17Y9UNFoG7bo
         KpTA==
X-Forwarded-Encrypted: i=1; AFNElJ98F3d+m8QW4nNWaKhoB4+ZDn5cnFt+OEeXB1VA1b9jhKn2+e1HmMQYQOb2TD2RkpPbZ3RpMZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01/DOODprueBPlk0fMiRBaUWu9WUphr7fzfxiVaucRRUOEvhq
	2mFz/S8XmCnQDt/SCyJGIAZtoVfCBb+9UsL9uJ9kZQo4h3fs1o4ftKGgHaIkoePcjLFmTHKSA4F
	2qxYcg23E2wCusjb+SygQ3sqbCN9Snsk=
X-Gm-Gg: Acq92OF90dMDb+hvyR76lTqPAunIVD15lEQ7UVExnyNNt9e2BTpgZ3ev2cqY2x2A2r9
	KK2sEu3/+VnU3MKiWhkszYRPRGi1EmDbWOpxjicznYuuO+cxq69SFtRjNQG134QJwHL4FOdmGrp
	zRguBRFbA1fERxnnVGXKQX+81mgn/3KSdc8t8nkN5AHrWlF2MFHAqmn2zbybokIIC2SU61mh7K+
	ZFtdfDO4fAmglGUR59eoKq4fLmBCey0+zbkd/SU93ugtUE0pZEyAG0XTiI3vElN7o1xxAOwnRwT
	UjE2Q3T628I4+zBUZGsilvwV4cj9poVqKAlVgBI+LlYyrzN7NYGbg8X0CcsimKcKqyXwk5z2
X-Received: by 2002:a05:690c:22c4:b0:7bd:92fc:bffc with SMTP id
 00721157ae682-7c510b7019dmr17683127b3.28.1778551690519; Mon, 11 May 2026
 19:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510053025.100224-1-kartikey406@gmail.com> <e1741cf2-3416-4464-bcae-741f0c87448b@collabora.com>
In-Reply-To: <e1741cf2-3416-4464-bcae-741f0c87448b@collabora.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 12 May 2026 07:37:59 +0530
X-Gm-Features: AVHnY4J2D1-C23A11f7UqzcVhKI94fEZIIYuSoxukd33EEp1xmrI8ysvEMqjWdI
Message-ID: <CADhLXY6wZfejdnGRKBy5raFE8U_VAivqx=oa+tmNAAOx-cSF9g@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: check virtio_gpu_array_lock_resv() return in
 cursor update
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
	olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, simona@ffwll.ch, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AF0F7518BA3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245380-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[redhat.com,chromium.org,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,linaro.org,amd.com,lists.freedesktop.org,lists.linux.dev,vger.kernel.org,lists.linaro.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,72bd3dd3a5d5f39a0271];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,collabora.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 2:41=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>                        plane->state->crtc_w,
>
> Thanks for the patch. Atomic update shouldn't fail due to non-critical
> errors like on a signal interrupt. Could you please move this code that
> may fail in update() to .prepare/cleanup_fb() callbacks?
>
> --
> Best regards,
> Dmitry

Thanks for the feedback . I have sent patch v2.

Thanks

Deepanshu kartikey

