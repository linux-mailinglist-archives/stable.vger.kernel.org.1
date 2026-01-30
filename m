Return-Path: <stable+bounces-212843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB4jNZZSfGmwLwIAu9opvQ
	(envelope-from <stable+bounces-212843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 07:41:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A62B7AA4
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 07:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 557353003BD1
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 06:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FDA33890E;
	Fri, 30 Jan 2026 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z+U+ny+o"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3295D3314AE
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 06:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769755278; cv=pass; b=Odfhfns5t/bJii/zH3xcUM/XDrIUNrkAFE8HN197s3YLBUxWMjlWyKAH/GTqMF4ooo5EIApMDyQMuDlBMWtJZH0jVEzKlhxxZ8AHnrdqEo8yEPSoHFSZ/GZ8EUdpRSoK6zJOA1RQlRZhhACFKKiAe0o/BPfZvyM+On2YZ98/POw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769755278; c=relaxed/simple;
	bh=e92lWZPVFugVAMygpaYDs5ATJ6LSykDjIR5hT6LiqIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pqz8f27CXqwW4g3jHB3Fzw+payFWgdhGUjxNbylo6P749zBdQ+Go81I7yBC9RraSkbhK08z/xu55I/IHHCpJKT2so7a21zd1Jd/HgTnzTCOKiDKSWXOmR92LuN0SDyolkl+UIcAhY6b86loxc+L+UB5X4CAs1BwBV1yt5IE2yN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Z+U+ny+o; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4094fbd1808so715071fac.1
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 22:41:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769755276; cv=none;
        d=google.com; s=arc-20240605;
        b=f+k3CgF8Dw6ShZlD4M+j1Q3dx71UJa++2SUPHdipJUTIPcXfW6ataKrPwP6EVQBwNj
         gKwSDlOAPksIAEdfr7XkhgEva43fjqzK6NqyyTJqYKrzX3bhn+qh9QDyyLjhYnzNCTy0
         P0WVCB/vt27sNhwL8jYC3/B1X8PpgccyPIFKSWHrc7fNZho08UEAAn0ikmQ+Ea/dpbNL
         FfrBkg+yHE5BnW/syP7/Egn8I+tyv6zgrmYQmI/iTsQxn6fRhDw9LNykNV+OPWAIJHUD
         0vqbYLeU8FWLykLJa65zl23U+T8KPU+dWMZABMyZcd60JX9qL1puZ14Lkf0Vxrn45nDs
         GQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e92lWZPVFugVAMygpaYDs5ATJ6LSykDjIR5hT6LiqIY=;
        fh=W65YBmETc133tNim6mzvjyl99T/KtxMOPkoB3NSIT7w=;
        b=STMk4sYuT092oCs7fpKJczW5MQ5D6Hx6frLjcoAZLGm5Vz9us9a+HFxduLWoQj6EtH
         oUynTkqRXupGMZsvErpKH5OU0dQCdEw8cq6ABEz0dLPoCZJz1Vu+tHgI59F1XqZTH41y
         AALzI2NmdThtMLixmyD9S9KFDTfH8LOn/n/JBnu7zPXz9yP6oRUnG2Zw4OC4sOwOVs4c
         jM7MreKvJqpUMhFpaXw58p/Ko6Ll1zuvYJHwBS2U0Gc5rnSf+l+R55hIoScPxQ2CUC6E
         1/Lf6jeWMw+pH7VtiKcqU+uwGBBak5cLygHky67wQ20tHWuRDuHP9iTMUeGaG8fRahew
         PMxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1769755276; x=1770360076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e92lWZPVFugVAMygpaYDs5ATJ6LSykDjIR5hT6LiqIY=;
        b=Z+U+ny+ozVR309fDpfHAkgiuhKmVmcmA9RFHV9cr+kETaUpQtabsqT9anfREO2JCVu
         mER6ZEVWk9yB7tgv4uPT7Ei1ikBbROd/SP+0Serpk1n55/HsNiSfRV3anp4mb7phmHdn
         GYPrrK5iTto9GOIOzZrniLCkogETBT0F8cOBhn3z0VWCE9f7qd/PTHuZcAuuVY+7vTcT
         7ZIbKz5ZUTwuf2gkbcvLsK845QpLArMKS2avwyi/JTFL/e0xJVlYgO+LerWDZ343z6Kp
         lixUieRJ344Zv/5g9N2z8K5hfJbsbH1xA+LF4VdxaVensy2xJ6b6oxWLSh8Q2wvcUNN3
         f5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769755276; x=1770360076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e92lWZPVFugVAMygpaYDs5ATJ6LSykDjIR5hT6LiqIY=;
        b=FVInDbDvS/lgZdtjOTUACtyQVDP3Rej2/B5Ctk1k2G9SGf84v1ZFez1XB+VBFLFHTI
         7I4soWYgT4D0PnRA3ENoCMBNSuIbSYNC3U15LjdBc+Eg9h2sQl/MmuLwPLbKyOIuWNeL
         7hG0aeq8dbWyPwcg7wWQgXBfR4FHVc2O32SrR6YRliZObpFE5eGTJ66l4WVj0fUem5hj
         93MWhUI3grAZCe3AE8IemcjPPHQ+z9d7DYHN2TjUhvvIbmOL063HnDiz/Xr+pYRgw3Tv
         F26RXMgSgV4vM/mpFoUY7/eDiBbsx/68yP+e1x5GKAGQo6hCFDfWWY+n/Z2/7TNqQeS4
         X/1w==
X-Forwarded-Encrypted: i=1; AJvYcCUGmVRO5Vl00LbLN8TLHzzq4cce8P6nOk+/ILKDR+8h8JP0FiSnvRz8LKJ+6R68EcCXLUMbgVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6dUjE5Br1S9kqgg9nVwfrqTiHiJapCD8HAf+7K1Io4ENxjTIL
	yNj29Kybpg1kTiK0k72LLJKv2FRwiiyzwLXaD/BDxeHmwlmqL9SqTPCudTVmqBbCuGmJtq2FRyM
	QKYSQBVQyLSSFupGJOzR4FXECR/gmu/8dMmFNLGKh
X-Gm-Gg: AZuq6aJypspqZjiRSNvaKuZ0uPPckLLyQLK2uB+kVTcAqKxSvhPhtU+TvRQ0iakiopI
	wPnnRzr2Yq5YT5HANvVZvWEOAZvv6L+yF+xwbIL512vnHKJAoFNMLGoOpLN2/IH2AVCs4IdEKSj
	F8WykdFTGz0wYF4tWepYKletzXm3lrg7e7+yw0E9w4GRpBgbgw2wRAjyMdh0CKJHs4ZYcMbcciA
	d2rMak12yQ6cF01t21L+Hgqrv1qpXGRThQ8B7CBCDMkokwfefhE5rPN0sEbARrxH68M8jdPSI7G
	dWFauDE=
X-Received: by 2002:a4a:ee0d:0:b0:663:c8a:f14d with SMTP id
 006d021491bc7-6630f34ec68mr804679eaf.29.1769755276000; Thu, 29 Jan 2026
 22:41:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130050750.4050-1-jasowang@redhat.com>
In-Reply-To: <20260130050750.4050-1-jasowang@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Fri, 30 Jan 2026 14:41:05 +0800
X-Gm-Features: AZwV_QjZWXvGY6fbhwTXsBsPoSEryCiwjIw8p9jgzeUbuJsf6rP1qz6KrDl9010
Message-ID: <CACycT3tVT5x3hoDrtuzqMgLgmw_1JbDtQwwJQ2o4mV2xUkFc9w@mail.gmail.com>
Subject: Re: [PATCH] VDUSE: avoid leaking information to userspace
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212843-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xieyongji@bytedance.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 05A62B7AA4
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 1:08=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> The bounceing is not necessarily page aligned, so current VDUSE can
> leak kernel information through mapping bounce pages to
> userspace. Allocate bounce pages with __GFP_ZERO to avoid leaking
> information to userspace.
>
> Fixes: 8c773d53fb7b ("vduse: Implement an MMU-based software IOTLB")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Thanks for catching this!

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji

