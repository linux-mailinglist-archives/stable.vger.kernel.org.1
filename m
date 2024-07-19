Return-Path: <stable+bounces-60620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37310937B50
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 18:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688991C21C70
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C21146585;
	Fri, 19 Jul 2024 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TkGP5pVL"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA5D1B86F8
	for <stable@vger.kernel.org>; Fri, 19 Jul 2024 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721407873; cv=none; b=EhJZ2w/FntWW+71IL5R2MXo1cvdOP/QT1hB15/0d5yGF/TAcnDubr/0eLB6GSaE7cD0MQ0hkUbIbqE5MTgE49TkkGJacvmZ8DScQpvXL0S0iGiDaomY/PqQLq5wLEM4y1ITjtk9gjyt++HQrDx01rsBcJGf7WBTY/SbVFZfzlrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721407873; c=relaxed/simple;
	bh=suyGWaqUqQpxidA0qe5zUYY1B6Ea/4KKlf7VEIU+Wrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pd5wJh+PC2wAvdRNaw0lDxuORt4Qxi+mMLODLj2efQ6fp+TR3LPfM3De1tdbEvGzY3r0QwpOV+GURui8Ve2zr4nKkY2dYSKRFiOAZ1qBjqnYDGe7eNg9Cpr/an6UF1F5bdAbKR2DnbrAS7SBvzAZ4P6t0gAg6g2VFkoEF+erIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TkGP5pVL; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-661d7e68e89so16456577b3.0
        for <stable@vger.kernel.org>; Fri, 19 Jul 2024 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721407869; x=1722012669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hf1CRb6FNxTXLmc8WoPLCBZSAPine/5ipBZyPoxKfzc=;
        b=TkGP5pVLgPjxuNGtHO/62ICctTtmpxGGnIe+cbFAAIE/vogFsmSvBAAAtxRHcwlyWZ
         C9XiZpGVEPJPtuiwliYPykOEI9RkHgW+7inXTiTYT8/vi7YwLcumwNLvJjszrhA0Th2K
         SX/OTdKtIOT0fw+b9ax5O+AILdBEzSV/URGf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721407869; x=1722012669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hf1CRb6FNxTXLmc8WoPLCBZSAPine/5ipBZyPoxKfzc=;
        b=Owk1vgza5vJOPTVAGMBh4M9zRkAyk4CfO8Liab/5NMoZlhOyB4nu82LvdPmUoyZQ5q
         IVwjMf/G+zwUSrM3nXO0jiikQZaQnMRc7pGt+fqt05KpH3FWg9WKYw7orWvBHyHj1Vz5
         YxzkE0X9Suy9GphL7ttWqwaPYYMKxt0rscK1MuLFtXscAxl3vyrqWrYXu/A0EzwpxJGi
         zIyvmIVYKlnSljJexX/rimIHgjHyI5TWdxTzQhbUank/z1cjCg8PA0lxGKNvQA5vbg2O
         6VHW63iUaZ8M01mHqjCLlxd5GgX/i7B0SWuzmf2HCBf0aitDmi+uVFhIboIoYUv4s+9y
         sUEg==
X-Forwarded-Encrypted: i=1; AJvYcCVDFMlZzH5ub0fVWZpXpiuba8VFO6GUPYw2zSxhUz2jxzcNf+CpEB8aYxm/fq3mKDM5RMnnGIBxhXTccsySVskuva5jAyeU
X-Gm-Message-State: AOJu0YwulgGg2lxt0Xw80Gr85acBE2g25Hz9cbF5W0LHJ+QaCxwTAmWr
	1E5MpC0MvbXLRZf9TuTLQyvj8T+QFb5P+dTBrqPK7NkntfrA4u6I88j8vHN4sWqq88+Su5dNizM
	/JO5xzXoJrUEFSVfoS8bMpp5e6NurQg1mcwk6
X-Google-Smtp-Source: AGHT+IHjw/mdIBtdJ9CtXyE6ZdUSxa1bQoYQxXnYcEvWAQfvu6Ek1Q7HBTHtbx2WExpB7oCU8juUPXdiADXIwVjn+jw=
X-Received: by 2002:a05:690c:2a92:b0:61a:e5b8:7a18 with SMTP id
 00721157ae682-66a6925fbc2mr1526537b3.20.1721407869563; Fri, 19 Jul 2024
 09:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718162239.13085-1-zack.rusin@broadcom.com> <20240718162239.13085-4-zack.rusin@broadcom.com>
In-Reply-To: <20240718162239.13085-4-zack.rusin@broadcom.com>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Fri, 19 Jul 2024 11:51:00 -0500
Message-ID: <CAO6MGthS85Mmba_-MpsK=0Q08sk6vqjgCxcjeqfhKuQ+OqtpPA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] drm/vmwgfx: Fix handling of dumb buffers
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, martin.krastev@broadcom.com, 
	maaz.mombasawala@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 11:22=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:

> +bool vmw_user_object_is_mapped(struct vmw_user_object *uo)
> +{
> +       struct vmw_bo *bo;
> +
> +       if (!uo || vmw_user_object_is_null(uo))
> +               return false;
> +
> +       bo =3D vmw_user_object_buffer(uo);
> +       WARN_ON(!bo);
> +
> +       return (bo && bo->map.bo);
> +}

map.bo is set in ttm_bo_kmap but is not reset to NULL in
ttm_bo_kunmap. We only reset it in our vmw_bo_unmap. So we have to
ensure all unmaps go through our vmw_bo_unmap or use map.virtual
instead of map.bo to indicate the presence of a mapping. I prefer the
latter.

