Return-Path: <stable+bounces-222504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4t/RKqn9pGn3xwUAu9opvQ
	(envelope-from <stable+bounces-222504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 04:02:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C1F1D2934
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 04:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE5EF300EFB1
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 03:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1137476025;
	Mon,  2 Mar 2026 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hZFuIcxH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439346FBF
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772420516; cv=none; b=ZS8j07vFy5H+TRJVv82PY/071raWnWjpuVWB3AajvNNfcCZM6a/bGAfHvHyDfP/XAQChmkfBJEACwIpt1PZpS2RKwGeo0wyfNEiQP1QFVSlJkj4VP5DiA2A0St1/G6okcoJhu9AbpZs51y/05zugHCx4ZXCV1icAiv0kKzWw3IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772420516; c=relaxed/simple;
	bh=jPdfbTWpli4XwxPUecTTL7S92bE50vibE6ffSq8TUuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElJ1qU72GrxGWyexjANAXeCaH8rLt5/8aMVxXZPfQM536zLR1OsS48BCheKRCoBaVut+ECafvOlgLTVjVzDUnTrjmlxbxziw7Mq/j6GVn0eGVGUUH/mHGrMMd6yhLYixcZR2MSvdujwzuo0x0vAugKrRkAMo/Q9dfIqZmFBzzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hZFuIcxH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so6958765a12.1
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 19:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772420512; x=1773025312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPdfbTWpli4XwxPUecTTL7S92bE50vibE6ffSq8TUuk=;
        b=hZFuIcxHmWXR1tnfE4X/HLiLJ0gsqFXopfei0WPse1a5AiSeLM0zw+O1WTWOc4Zzss
         4lSurwn7TCC2AdJZ3U6oMKunroxDcT4Pvv3qWGdJRfPwfNelVkOaLdJwr/YBl8Uj5FnR
         MwQbSKupx+P1aRIGCNhzuqwX6XKu9uUUslpLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772420512; x=1773025312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jPdfbTWpli4XwxPUecTTL7S92bE50vibE6ffSq8TUuk=;
        b=WRJ54MK3hjfQE+bKWhmCfbg7/kESKexXce0TY7VmwtLHw2O5Mf7GF1VByn6/wCYzFU
         iPz65zvd5q+tJUMIwSP1YUmkO3c55gfWwCagAUcO4C9CWLb/akT0M6FMcg4y58lvcB7E
         f0VIiut8ogv6mU11seOnirRHrtRiqGimobtW3mcPd4xvrSFpdy8/V1VB7LgspMsPw5fp
         Q2oyfTLFF79cx2SXAAT5vZHMOThb55JXrIDdl++cMnaTGnHy1yh4KHzJa+w4ZfkSqrrm
         ouxs1v4sijlWEsfBR466k61+uEC29AUY+x0v0KZecOWgUcui56nPQ6TcGsPDG/AMNEq4
         J4HA==
X-Gm-Message-State: AOJu0YwHTc/iEQYYm44C1jX3WgNQke0E2I+HL/A3AykZXk0BUkeEw/yY
	4COH7GNCB6g3IhaE3u4uDuc+tnBCfdXHb9CvCZeoRWCmrStiBX7DrOtjx0215CHeUebJSXDKADp
	gt9OQMg==
X-Gm-Gg: ATEYQzx3i+Bx8DwEOTfcEIFencZBegowHs0Fn18syr2uhFAw19zdr4Rm5kGIEILween
	xn1/nvY1UQQ8vwK+eT3GATI9juTE3FnAYKs6iMHk3Fy0T+skPITL2gI5hcjNWREviGOXsuwfBG9
	3+JQBDN3MAtCkZTQ75JBg8c07WevOpCkEy8/rGb6IfhmAmwYAE/i9pd/fjMLWvkLU6kyQmIEpR9
	XDoz8oYL/XH1iExKz+FEI/yYvJ752rPFkk9abxrNOEiwc9X2i8AnwBXYN6H/d4nm1nh+le+xhX7
	keUPHRRtb0WyBuj6/e/29IzNKi2m17y5D6I1gDEGvG+6pgG20IIpMd5CTg00/bMGdNZA5AI9bvB
	8VX+cLGfODACsZsVmgbnnWWH5YDfyyWl05K0meChPDerMkEg9DAe8IL/TxL20o9XuCz+O+EXHtS
	sEJeGPRxbrT57JJpk/0UseUvMONzZuiVHbRFAWb/z3NLh9xC6K9FZpI6vqmFIOeg==
X-Received: by 2002:a17:907:d105:b0:b88:713e:78a5 with SMTP id a640c23a62f3a-b93765212d2mr639553766b.28.1772420511853;
        Sun, 01 Mar 2026 19:01:51 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac513acsm423651266b.18.2026.03.01.19.01.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 19:01:50 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b9b1900bso121760f8f.1
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 19:01:50 -0800 (PST)
X-Received: by 2002:a05:6000:26cb:b0:439:b3d2:376c with SMTP id
 ffacd0b85a97d-439b3d243f3mr5543114f8f.12.1772420509641; Sun, 01 Mar 2026
 19:01:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301012249.1679321-1-sashal@kernel.org>
In-Reply-To: <20260301012249.1679321-1-sashal@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 1 Mar 2026 19:01:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XAGzoRaA2bFT3X=eqiMR93pSUkXyTQk6euzhUR+fUY9w@mail.gmail.com>
X-Gm-Features: AaiRm50UI-GLd6YrW-98pHBxkwel5ieiU0A_OEUDIQXNRQlwyN3UVvOtaaBV7Bs
Message-ID: <CAD=FV=XAGzoRaA2bFT3X=eqiMR93pSUkXyTQk6euzhUR+fUY9w@mail.gmail.com>
Subject: Re: FAILED: Patch "mfd: core: Add locking around 'mfd_of_node_list'"
 failed to apply to 6.12-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-222504-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01C1F1D2934
X-Rspamd-Action: no action

Sasha,

On Sat, Feb 28, 2026 at 5:22=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> Thanks,
> Sasha
>
> ------------------ original commit in Linus's tree ------------------
>
> From 20117c92bcf9c11afd64d7481d8f94fdf410726e Mon Sep 17 00:00:00 2001
> From: Douglas Anderson <dianders@chromium.org>
> Date: Wed, 10 Dec 2025 11:30:03 -0800
> Subject: [PATCH] mfd: core: Add locking around 'mfd_of_node_list'

Can you give any more details? I tried:

git checkout v6.12.74
git cherry-pick 20117c92bcf9 # ("mfd: core: Add locking around
'mfd_of_node_list'")

It seems to apply all the way back to 6.1 cleanly. NOTE: I didn't try
building with those older kernels. I can try if need be.

-Doug

