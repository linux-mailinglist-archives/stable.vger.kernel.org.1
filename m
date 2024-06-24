Return-Path: <stable+bounces-54993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B779147F9
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 13:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9FE280C8E
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47250136663;
	Mon, 24 Jun 2024 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NhEKSraQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714C45025
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226906; cv=none; b=Zdh4nKzGxlljFkt0e+626O/ZGFFO/rm7zkPqYwYO39ryIoa2PBDkfgI0vo7phhmfFaPm1PVm7PoRjPJo+R2/xhWxREmYSg2QAlIUXv2V9Xvmav5pf3vTaqeYI0z7O6NpvhMjENjJj9StlDkcnQHHUkC3CSiQczmSgngBTewgMVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226906; c=relaxed/simple;
	bh=g+UI2h+MbGePnkXweRNbz/BpFp2mvZy8j4UxIIDhLSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dm4AIWKA6jG0ag43OBn4/WtqY9ZDU9dsBwGH07DU+EqemAhsHFqw0oqmJJglwbnoOxsc3rhVhUufECIXj+u1tA5ckE7kMBIozj2BObys2/EyhrnLKT/775I/Y1A33I9kynd9LSWgWmJhrNSUsA/WSoEtyzeKR0TMqs/CJ2s6efs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NhEKSraQ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec10324791so49918871fa.1
        for <stable@vger.kernel.org>; Mon, 24 Jun 2024 04:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719226902; x=1719831702; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xbk+wnOEmNszGUoP4v3r9GEXmsbbE+/wd4rojn5Lqnw=;
        b=NhEKSraQ2m7+vetuQcQhJEq/Ty+XV+HIdFQEaDlkgmRIbn607Z6WctVCqsPx9RKf0H
         ZCL8p7muO8fk6Ov7tBeevYjxuKpDKUfsSfPHSjCLviIgfuQr0Vojmfcp/gQ/d0RFD3Q5
         FPPv5gkUT3tlzhscPsWTrrE4UuLBcbTpBbC2BST284anEl/ETKvnQpuNs8SdNpiKo9uI
         R27W5keEUdeZUI6J3KG5EHmydeBguwdQxpjYCFYRcmeUjWuPoLy2AdmGChtghFNNw5bh
         oHMtIhcD/cMVlRYWXi9gPtaTKLf8JuhoQ6GxGfWu6xUAmKmV5FrmNqOB33rcGJBQAWV1
         suDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719226902; x=1719831702;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xbk+wnOEmNszGUoP4v3r9GEXmsbbE+/wd4rojn5Lqnw=;
        b=AqHoAISiz8ZL/IiSX2ABECpEMLo+wWTv2NUduhIgA7Vvg5mkfnSga/m+QKOWLsj4RZ
         EtiYbdVqQwFPOKc9ucfZgCiCKq2D168hbZhf782Npb/aMWZ+Zv/NHxeEc/a4ONJhh6ok
         ytlR33GNp3/ZLsBeJU1ePIcMlNDnyysJ3eRIHpIjSjtL3+78q5Uxoz9vmd8Ut+hhutVn
         HAFWZ8U8y9H8nuFXV0FQJQldgkTy8p4PRjaZFHX2l5NCd4iMGh2Px6Sf1botR3S5NPnf
         axjoodPKa4Z0SdL3JzdmmuNXBtSNJX5vvZfTJB+zWSS7+LQm6aMPhf8Z6PoWfnyUhK8h
         YP6A==
X-Forwarded-Encrypted: i=1; AJvYcCWzZA4DYRGP+cEX4freeMhsA0tWKCGybk6NmBeg5IjH7wph+VSBE+DtEn383X8uU5Cydc2rEj6kejpEn84gfxDXShN4saw3
X-Gm-Message-State: AOJu0YzIvFmljFJuO+YFG7iWFECuh3NNKu/5gmZqN9DnccspUlmCfju0
	EbpS7x/Ih+Bbud7SKnEOA0eb2lK6mXi6UL9oGbPGTFAtxrb20BCtAJwW4SQEV44=
X-Google-Smtp-Source: AGHT+IHSWtAgQHovXxTzoDGYAhW6mCaubV6lUO2+ifOmfKeJEhvEGMv6lloJzC1GDEF/16hsCBqg+Q==
X-Received: by 2002:a2e:b011:0:b0:2ec:5019:becd with SMTP id 38308e7fff4ca-2ec5b2e937amr25874761fa.49.1719226902144;
        Mon, 24 Jun 2024 04:01:42 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819dd0cf7sm6407091a91.48.2024.06.24.04.01.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2024 04:01:41 -0700 (PDT)
Date: Mon, 24 Jun 2024 19:01:37 +0800
From: joeyli <jlee@suse.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-block@vger.kernel.org, Justin Sanders <justin@coraid.com>,
	Chun-Yi Lee <joeyli.kernel@gmail.com>, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jens Axboe <axboe@kernel.dk>, Kirill Korotaev <dev@openvz.org>,
	Nicolai Stange <nstange@suse.com>,
	Pavel Emelianov <xemul@openvz.org>
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <20240624110137.GI7611@linux-l9pv.suse>
References: <20240624064418.27043-1-jlee@suse.com>
 <b75a3e00-f3ec-4d06-8de8-6e93f74597e4@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b75a3e00-f3ec-4d06-8de8-6e93f74597e4@web.de>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Markus,

On Mon, Jun 24, 2024 at 10:40:13AM +0200, Markus Elfring wrote:
> >                   … So they should also use dev_hold() to increase the
> > refcnt of skb->dev.
> …
> 
>   reference counter of “skb->dev”?
> 

Yes, I will update my wording. Thanks!

Joey Lee

> 
> …
> > Fixes: f98364e92662 ("aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts")
> 
> Would you like to add a “stable tag”?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?h=v6.10-rc4#n34
> 
> 
> Will an adjusted summary phrase become more helpful?
> 
> Regards,
> Markus

