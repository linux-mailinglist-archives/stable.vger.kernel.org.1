Return-Path: <stable+bounces-67760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7DC952C67
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 12:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDD42858E5
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1341448FD;
	Thu, 15 Aug 2024 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LSNgq5MO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4D4A3E
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716041; cv=none; b=UY4yqCu4MKgR2aAWqO7+7sRdURRZSua3Dk6bQtnMMdLW0XzgJy+N8FAwj5JB3r31ttjoVHGgsdcyHsXdHK/mXpU9Ci1BTuYMlK1Nd4xWmm4tFFpp+qX+EN4v50ncKE6ltJPj57KX8Xck6DdDyOL17fgYwrS5rUynTYK4+Luup4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716041; c=relaxed/simple;
	bh=6GHbETPPC/B/1h8t6uB9Eun0Lhnp/zyhCpFIMq/RNB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uORx8+VvwR4cxhPP2v1Cy/AIhkXzKOP9cE+JeFLQkrkOlEyBWZlFKEbWJWuqL/E2trOUl3S3tJQue3zDkI3Ssd2atJORh8QN/n6BEHKdmT2I941uAQR+7ObeZaKLorsGE99/ZKfHz+ARamug6kUBIwoRvOTBPZFrgGERsH3NjHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LSNgq5MO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-429eb13a9ccso1200235e9.2
        for <stable@vger.kernel.org>; Thu, 15 Aug 2024 03:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723716038; x=1724320838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QhqqyUskTcZ04Sd5gpzfZtw99v7GyBxBE1TibBPMa0Y=;
        b=LSNgq5MOtM4cU8h/KTydEPs9xT14UMlwqf8aLB9pBGYOkRtKCdzFcSrfH3bUpMmOyP
         gV1zlnLVFfvM9QXmJYx2Fic8aFdyAc6r63zsoVU9LQ5HWWFRlHZx/10Aw4AE85zqFJ6o
         0HX6JcCvVoyon/qgmRhlBtA2JysDxsg1wTo7WjLZoFK2B/8ANQSloi1rwWm0O5CzGpIW
         dqrYLJ5AA9tBLFJqz+lJD2nUDPhxzKqC86lWfl0P3xkeo2gLXfqHwIgtt5xBbQyEiAXE
         Z8fz6AIY9LDSbjzIIAk5WO1DMZAfSLhOZvTjfaW5tnrS1f3+je19a5qnCmKzUriUKIuG
         iyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723716038; x=1724320838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhqqyUskTcZ04Sd5gpzfZtw99v7GyBxBE1TibBPMa0Y=;
        b=eEl2Yn5ZBgrjpEzhxaiCH8dK7XTQzceqyjFAdM6UGIHK92QyCHxU1ggxHFF1ceMs6G
         YE7KN72E3nq4As8T+eq8ku0lmk7RIkunw5F0yWSRAwHafET1NTdwpjOFFn8UOHqNiwZN
         sdeeC9j1vv1JvAK9Me2EXDBq1ANA5JutwmtUH/34Pi7H4XhqTya4lRHqTxsiVd+w7d3n
         jxDDfVPMR9Xxi/L7gmfPe/KGceNhh5s8eBk6mr8w716Q0AAp79hgcTKv1WYuChtRSVoV
         q1JLhM6pnADIfYtksfQqTmdTiaAqHPaixIhcuYnn1Ej2zheSU6aDxHK741N59cHGGJqM
         9MFQ==
X-Gm-Message-State: AOJu0Ywq4L3G7guv4Uf3MGl+0syjIFQz+X7VH37McSOBgm+lI87rNt6X
	2J3RF7tRPLQMg1CY/62qNIZrMpmSQkNzmcVvUsiggp1lKG2mUIt0aWTy5l+/fLFxCqorX3TUSwk
	f
X-Google-Smtp-Source: AGHT+IHww4OWyanfDio0T5TudWyimzwe45bbB7fxk4PgsGoDlm0bZ4uZHM/UyNZ4rOvkr9MZ39oZpg==
X-Received: by 2002:a05:600c:6d4:b0:426:647b:1bf7 with SMTP id 5b1f17b1804b1-429dd32c3efmr45142765e9.32.1723716038150;
        Thu, 15 Aug 2024 03:00:38 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7e1ca56sm14468855e9.45.2024.08.15.03.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:00:37 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:00:35 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 017/568] cgroup/cpuset: Prevent UAF in
 proc_cpuset_show()
Message-ID: <vxrjoloxbtddsmdqybntugwocztrjrnu4urqdfkcm3oybusyeq@4rqtm5foijgs>
References: <20240730151639.792277039@linuxfoundation.org>
 <20240730151640.503086745@linuxfoundation.org>
 <xrc6s5oyf3b5hflsffklogluuvd75h2khanrke2laes3en5js2@6kvpkcxs7ufj>
 <2024081444-outwit-panic-83fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v6y3yibrc3ombwdo"
Content-Disposition: inline
In-Reply-To: <2024081444-outwit-panic-83fa@gregkh>


--v6y3yibrc3ombwdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2024 at 07:45:54PM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> It is in 6.6.44.

I meant the commit d23b5c577715 is missing in the backports:

git grep "list_del.*root_list" torvalds/master -- kernel/cgroup/cgroup.c
torvalds/master:kernel/cgroup/cgroup.c: list_del_rcu(&root->root_list);

git grep "list_del.*root_list" v6.6.44 -- kernel/cgroup/cgroup.c
v6.6.44:kernel/cgroup/cgroup.c:         list_del(&root->root_list);

HTH,
Michal

--v6y3yibrc3ombwdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZr3RwQAKCRAt3Wney77B
SbgOAP9wFVcU+bcey3YCLyDxbJVX5DJM8ZJugdei99xgJdTRPwEA4b/v/m3Pl8z6
WIu3n0VkSM7SS/slmDgwGpLn/akU6wI=
=JKW6
-----END PGP SIGNATURE-----

--v6y3yibrc3ombwdo--

