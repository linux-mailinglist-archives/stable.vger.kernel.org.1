Return-Path: <stable+bounces-133206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4F3A92057
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 16:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12E51895F6B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42AE2522AC;
	Thu, 17 Apr 2025 14:57:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2D251786;
	Thu, 17 Apr 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901840; cv=none; b=jfQHSA8vpSgRZtvSFeERnLOQuo0saOEKipSHtjAZSDWjLx18n5XOHdfRd33fdKLgiqLOPSv/0RasMgfMcLdwkBaOQyaBg382UekJLwWkMVq6kG99sESrVoYXOJtwbdW13WqaPYiALmb5bdxHQF4/1EyVOhar0zGcE1q3mpx94ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901840; c=relaxed/simple;
	bh=43cUQQ/POxVEKEcRqV9oLopGE8Kgw8pdLeBHNd36ifI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RW83PkwUZKo0gE48Lc1Y5USXnsvz66pXSKBNfbpPf8UT9fHjRP/aurP+cc1KbhPpz89ZqUmrcXqz7ieFdUNPBK6JsJ3TMof7O8ZG8wDCjfD4x2NxrhOSNiQ8xUk19OvFU5BQGaOLEVMY6wcQRvuvVwVmbYnBo4K6Gx4tNyPAMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso1659592a12.0;
        Thu, 17 Apr 2025 07:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744901837; x=1745506637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Gh8ITy2Mj96Xjqahpd8oLt4VUflwK2+491DCvx2k3Q=;
        b=N1n8NCnoBw+8o2GynNK7P2T7yjKCGRllF11j6707zHqyY5sodPg7RENf0VoMr3ospR
         i1+B8JX9pb4bncUDYSpSf94lnRy/WSI1QHECFk8RZeMbxXZEOiG9hGGRL/1r8JAvq025
         At6Ep7BMs81kTfddkDzzkCqq/w8qhjbRsd0U8rv99RxYyUfE9chzxaGZjzXn/6jsSUuF
         ONfNjgxJfdQomXmk8xvplRNmhQBew5IcBUxt6Yv1Urdhp3Jv2bqwnwytR071wrsoWtPs
         7tkjK6uLWC4yiEo3iNyIUyEw9BH46HHOflR5qHucqSh6lfRUuTVKqux/WwwON7DjSI2y
         iSYw==
X-Forwarded-Encrypted: i=1; AJvYcCUrHTXRFrkrFBgIVZxBSxtw4VEPNr309EoOjPcLk3BGpcTHh8hZTngAG+vDVSOoDu262bJJ/3Qj1f5owLY=@vger.kernel.org, AJvYcCW839B3Fp3lsPdPLexLGbyhkjYu5sC7ZG6xOx1fGT/ZuNeSmg5+QxNUEU0Xqc5z5sErRG+NiK2/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Jfzg4ILfUnjts+O2kvg3cTd4lF83/K0M8bqmVqBPbguWDqa5
	bSaRpZ9N6iW9Wu52FeqfvsxsOEIz8GUdVq/IzpbU8l8gMTLw+JB8
X-Gm-Gg: ASbGncuJjVtGoZ/x9PbdfF5ywH0kcSpGT22q4pYMnxThkl9T35nh5q656dQyQsydYKJ
	ORKVLGfUI6sV6wc01tryiEHfQlfsnxmtr6RUhub9TQXbND4GEzVU5b+6nsQ1ClniT4QySHLcfV5
	9rSv+cn6OHW3CO4RX1gHrh+ceLEmPtrXFrvDup8VLX8rXx2xm48nxaZec2c60kEnnPuh3qVyBgr
	DZgFWt05IaXwmEn8J9QUOUliXpBkHuXsFMom+M102b1Rcq/doEg4pduG25aH4vIjITgq5FfaAIQ
	a3FVjkMd+RJbVdE0Vn1aLvi2Rlv8UkDN
X-Google-Smtp-Source: AGHT+IGqdqJQMW/wgBjDlEpytEBW10F78/AG6/4JNZVA/ep0S0U5EGtsIhUifPI41ynA+pSlNbUNTQ==
X-Received: by 2002:a17:907:3cd5:b0:ac3:8896:416f with SMTP id a640c23a62f3a-acb428ef9b9mr607447966b.15.1744901837010;
        Thu, 17 Apr 2025 07:57:17 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec0b389sm5227966b.20.2025.04.17.07.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:57:16 -0700 (PDT)
Date: Thu, 17 Apr 2025 07:57:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Joel Becker <jlbec@evilplan.org>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] configfs: Do not override creating attribute file
 failure in populate_attrs()
Message-ID: <aAEWyoqVFEknPSbH@gmail.com>
References: <20250415-fix_configfs-v2-0-fcd527dd1824@quicinc.com>
 <20250415-fix_configfs-v2-2-fcd527dd1824@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415-fix_configfs-v2-2-fcd527dd1824@quicinc.com>

On Tue, Apr 15, 2025 at 08:34:26PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> populate_attrs() may override failure for creating attribute files
> by success for creating subsequent bin attribute files, and have
> wrong return value.
> 
> Fix by creating bin attribute files under successfully creating
> attribute files.
> 
> Fixes: 03607ace807b ("configfs: implement binary attributes")
> Cc: stable@vger.kernel.org
> Reviewed-by: Joel Becker <jlbec@evilplan.org>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

