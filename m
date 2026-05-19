Return-Path: <stable+bounces-249615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC8VAwJ4DGqihwUAu9opvQ
	(envelope-from <stable+bounces-249615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:47:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0859A580CD5
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 844403024D61
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F12348C65;
	Tue, 19 May 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MW76B4vU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B53F32AADE
	for <stable@vger.kernel.org>; Tue, 19 May 2026 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201298; cv=pass; b=uMjgs/xpIYY27i5CN9CfKDpm/bCLZW+cNH+vvpcBAgEpclgzhw73b1n9LCEt6KffzMHBL+BexSIU1eDJFWqhbNq4192VI+NSeUvhpX+1XS+sd4R8jOXdJxQwqqG8eD5eUuS5wl+Ov0VoaiRopb5GYmb3HfDFGDmb0de5iE8gORE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201298; c=relaxed/simple;
	bh=jzuXZgF3Qrmd6JYQPtb9iWDbLS1sA1jibvcsjdBphjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zo3RFv3onoo4Eq/YB0J9J3CloManmkWz5W6Gj1SpYExyYZ2hQf3mRWboQEczzVDn7ZqGLwGPtWoK4ojEiXPSlqjP7UKLpoWsjH9OZeLDX9SwbPeHgaUA4VZf9EUvuNvApDvOtQTYB/8kC9alquPNUQbnlE3LWlNjGCbzi/LrWtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MW76B4vU; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50d87610513so45520611cf.3
        for <stable@vger.kernel.org>; Tue, 19 May 2026 07:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779201294; cv=none;
        d=google.com; s=arc-20240605;
        b=crx0NLpXB23UpiVfKoJTnDjWzM93WKQ7KXFnyEE4D7t6CGlCW0Fp/kTe3/oerZRGfG
         Dx0RNYqM6JxecAnKKdFTf/XkPrMe0ikU8d46aF2WuvG+tUVmSA5xOZL6f/ED9qSGGwoa
         M4PSmDH+fwrj8jof+9YRVcd6ZIvMfARqrsuzF4k5up4pb08j/TvlH2RDJ56PTP46N55k
         tpbVtPMfEXTAAkDFWnvv2URxuvmbobGbQfeRERNC0+xkCw3wvQqzfuFfTVoprAJpAE3r
         x6wgIJlKWAP17Ohdqs3bqMj9hNdQjXGdcrhdOmx+qWhzTKTgPpFqrR5mgVQAEbBVqDTZ
         1rjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jzuXZgF3Qrmd6JYQPtb9iWDbLS1sA1jibvcsjdBphjc=;
        fh=8oe/tnV26IzyGtWTTDmiDeVz9E8iMFJC4nOmZuoF6o4=;
        b=JS/2a4YCgZXyCDePeCf6gitVc5/uYlCynBU8AKkUlVCO55ifSPjnE85tgKmf2n1R0z
         ndYMuAE0HJvsVV7Ik8AMRckeFVqd0R2oTyp5StBgCt1iEUg2Hw9Cj/5YpAmBOdF1gmZA
         g8rJ8c4m3tmjEK6+pcQ5g+geK71r1ED41skIX1WBkhwoYX6qz35qCHxbf9g7399k8IA5
         +ALGX07Ocgi0XOi5KlT0+xRfBN3bcgMMTfE8tOpS2Co7i+sOuYqs1ZYYw00Iu8g5X1Wx
         2WMvNO/EOYEjJpTviy6ZwkiLsqTPRlvOq4ipi0q9XrjLewo0LGj1I/e8UUv+wSZuIlAg
         MehA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779201294; x=1779806094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzuXZgF3Qrmd6JYQPtb9iWDbLS1sA1jibvcsjdBphjc=;
        b=MW76B4vUG4iqUZQ630WpZkiaA4gJqJey4Fnx9+gRE5L9EccKfsm6dzz4TUPTKPIKVm
         p0ViacrAmApl6FM3WElFBiVdlC3QowyfKcWq98O48L/U4mztBv5L/DFrCoT38a9rtvnf
         teUA75DMizMtElaAuLdabVlmFR5O+SI4zH7d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201294; x=1779806094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzuXZgF3Qrmd6JYQPtb9iWDbLS1sA1jibvcsjdBphjc=;
        b=qwmeUV291pcXXtjOrhXzvsdiQiwhOxiyf/AUPZn4mzutjRFDUFKjInqWZ1bZ8VSL8C
         emL4z+jBdbDRFtVuNSx8KC3FLYgWlMmSHDnCmqwanv0LO16aC4g72GLGs54zMwnD9W/b
         FN8wVxvOAGezQJ7MJPdXmr8IvpCp5WDwiEj03LreGQrBA0nCzxJfG7HqJcvUSsqr1AOt
         G4k80LhuESs6uAWeBJDPjkIghxip6/XooV0YdIyGGCPD6wFA3FcCxPRl4HhD5wFJsjlM
         YcnKJIWAWIsQU6Yk8mUpfy/MXSdK1HCUut4YufLzEStSVHYmRtuQqqjUOJs5YXYMKETR
         S6jQ==
X-Forwarded-Encrypted: i=1; AFNElJ9COBPTiF4ieaenspKY9E7HwRvGeulohLN2Po0UYc/H0zemkkF2qgjTfYYKHYO8u+0g8uQdykk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgO9huXwGQZdenacueb/iK7cF9eA2k2I6d5BoreVTJBjZWhbBy
	uiAdvbs871plXFmUnFTkcOn1FmD1EGjLeg+v9RgPdd3HXX1quqk+rX4C9utpHywgIvOgm579P+K
	Kqq/V5V5pfauCuBjFuYfsIIGIdETenV48aZ9nVDWZ0OJUqQElsR4c5W3zAw==
X-Gm-Gg: Acq92OE/PWQ9k/1J13Ea2Vq++Q0xjgXQFCG6owOUdAPugLWgsXvqKSiSAL/jXTSJguq
	Vudy/wgmX2v4gx9w5UAYTebyH6fSjFifiaP1ft0Z3fyqv6JBrkhYmoqR8x2m1IspXyp1ru9eMuN
	He6mr9YraTaSosMWN5n1Lv/EFNYqMW0gKV8NclgNYi1y1xNj/p+AFGE00uQ5L6xE80+lT/0w3Jy
	SCCiiNMob1FckJ9fB8FVodcucusVH3VujBALGAdEwfFTWXqzpRhpxyatqg4zzsy6Me+DdibNlAy
	qS8K8FddJ95KSznF/BoCoSLVlP2ZyMTLKMwUHio=
X-Received: by 2002:a05:622a:d1:b0:509:1b76:e9b2 with SMTP id
 d75a77b69052e-5165a276812mr277461251cf.55.1779201294168; Tue, 19 May 2026
 07:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519-fuse-dir-pagecache-v2-1-5428fa48e175@google.com>
In-Reply-To: <20260519-fuse-dir-pagecache-v2-1-5428fa48e175@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 May 2026 16:34:43 +0200
X-Gm-Features: AVHnY4Jg59xybOxPkwhz_VWfCMVL-W4M2Tqu4DnxVX0f0TXClapA1CEdciRZeWo
Message-ID: <CAJfpegtf1nujj8N4S_QSa+zPFTvCypj_aWEdUqyz2nUJgUh_KQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: reject fuse_notify() pagecache ops on directories
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-249615-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+]
X-Rspamd-Queue-Id: 0859A580CD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 at 16:29, Jann Horn <jannh@google.com> wrote:
>
> The operations FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE allow the
> FUSE daemon to actively write/read pagecache contents.
>
> For directories with FOPEN_CACHE_DIR, the pagecache is used as
> kernel-internal cache storage, and userspace is not supposed to have
> direct access to this cache - in particular, fuse_parse_cache() will hit
> WARN_ON() if the cache contains bogus data.
>
> Reject FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE on anything other than
> regular files with -EINVAL.
>
> Fixes: 5d7bc7e8680c ("fuse: allow using readdir cache")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Christian, can you please apply this to vfs.fixes?

Thanks,
Miklos

