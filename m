Return-Path: <stable+bounces-134550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C5A935C2
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 12:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A683A9CBD
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 10:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5C6204F78;
	Fri, 18 Apr 2025 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2M+JHp/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB43155C82
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970564; cv=none; b=q4Afl2DNBHUsrfEYyZudxtvUvC+35eeWcIjvmWletyevSoSthByHOh5WtEXhuPjs01bfx+AwfJ3B3yTmXBPiQSPtcRcQPVbQZ0wJ/jBoPUmGlWa7nGMZPXzMrV4OqASzDS5y5mSJPO0VAEf4WdSs4+m3sBtiKjt1pgdWzytJuYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970564; c=relaxed/simple;
	bh=a4wNsOa0/Hjb7GS8LEX4zQpt7vFLbt9oI4xxdgoFhJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mFX4+I1x4b/Za43vHrmTshrbtQ5h+MMlWdyP3Z8PP0bME/OKLcwUQnIQ4UiiEMxGVm3ppsZ4PXFCcIugiNu2k1NSgfxN3BAonJrnnFPbWaoY54x0CBFRDLdYgLW7Y2Cy0M8v5lmRALJEW/OtjMK3tKZTcjIJXPC++ozx3n2IKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2M+JHp/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5eb92df4fcbso3135167a12.0
        for <stable@vger.kernel.org>; Fri, 18 Apr 2025 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744970561; x=1745575361; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=a4wNsOa0/Hjb7GS8LEX4zQpt7vFLbt9oI4xxdgoFhJ8=;
        b=Q2M+JHp/OlhVUPiwmPiLgcSVsmJpKFQ/VuIaGtyZf2FdpdKpwksrvUngH7b30y+LyG
         VOXQTTNtdt5ZnbHzNacHeoPAdKkOQvM8zohd8Npgy2Kq/DJdGAf2qzy2X9zSAIkufTFF
         oziafwrlJtYTpvHMrfYoj8c30X/1YBAoxsE7b/qkG8fL6BXGzRFw7stjgnZHawRIDUpe
         kk2KXiTdT1/+Smkp8tosqVXJ8E2TPjrXZK+sxFaxrST3GjTGT6vvVIsXppU5OudhYUSB
         7XJqCBzZwU17KxZfHl4kolCqvszxtSEKDs4cKzbOOmFx2GE9dShpYB+ceW5YGUdj2Wok
         mDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744970561; x=1745575361;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4wNsOa0/Hjb7GS8LEX4zQpt7vFLbt9oI4xxdgoFhJ8=;
        b=jfn5UgcHz0OjdJ44lDZ52SV0F3gho15XByBSmIUmXJPg5dp4VW//BkNYHFRrhddBz6
         8Kz9tshLS+nJCVw7KfQ2qEfDxEZvdMOJJgry4NSy71jhKnHx+OrxoB/mN5a7EMQQTjLs
         1ZibsU7uvw8yUvjrgyGWayBI4K79BxK69v4nCkrfIUYilFwBvanMsCctja3En5G6UBVc
         s+8DfpINEcCcw1uLhZMdL9PFjBZ+Bw8EBUnlsaRqPkdiDwXX77kOW5kFBP7m6Iu+PDXF
         63e9ylDlF1v7F6C4d3bTxaWD+r9Hn4jB4SZ6VJzzh7ZLpw9c+r6Pu0NVAUgQ0cOIEl/l
         W1SQ==
X-Gm-Message-State: AOJu0YwY3AtyKqy51R50cqAk1DjDi39HOUFVAKfQMWuJFWS5aFLaxXIY
	65Vu7XhZaodTIGTuJq3EoWPtFG9IXkWBnoH9v60Alxv3izi6YnSOx+q0G0Cr
X-Gm-Gg: ASbGncv3xxhfZjDyDqocUn7y4SYAARVUU8r3xN1aEacAfFfCpkgI510L5strE77sZuB
	HoXUhTtS9FsMus3zPcEpyffZrfzrUhAso05TRkXKkVDgldcgss15Z0ikRpbIl22UDVGOoriTzCc
	gw7+mO8F8+RhEOo417tD3sWL+gWlUjgSmJ1bAHEa16AisSy11sLtLooGiZjCL8Db9A7TAIHTLDJ
	Lwoq5DQUjg03FX9NLKLX7w83V0gy2qxEU/XmUUNpQQExvLTgkKLnkHuooFfVwVz4yl8wwzRgpjD
	iaaTSEoaLLd16f2KG6PFbypp+8w8jCAPZrqDN9qsPRSqU0+l2pUy+m54UjQRhGr1dkDudABhOg=
	=
X-Google-Smtp-Source: AGHT+IHioSohvbh1vocHUH5gZSRlHIAJe5g7QzP90GwRdKaKGmRQ1nPisiHvh2HhavtoS+r7K2s/Cg==
X-Received: by 2002:a17:907:7247:b0:ac2:b1e2:4b85 with SMTP id a640c23a62f3a-acb74ad95a0mr204519466b.3.1744970560660;
        Fri, 18 Apr 2025 03:02:40 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefcf4fsm101266366b.109.2025.04.18.03.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:02:39 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 02084BE2DE0; Fri, 18 Apr 2025 12:02:38 +0200 (CEST)
Date: Fri, 18 Apr 2025 12:02:38 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Guillaume Morin <guillaume@morinfr.org>,
	Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: Please backport 8542870237c3 ("md: fix mddev uaf while iterating
 all_mddevs list") back down to 6.12.y (and question on older stable series
 back to 6.1.y)
Message-ID: <aAIjPqdxqGRuTyrd@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi stable mantainers,

[note I'm CC'ing here Guillaume, Yu and Christoph]

In Debian we were affected for a while by
https://bugs.debian.org/1086175 which we found to be reported by
Guillaume as
https://lore.kernel.org/all/Z7Y0SURoA8xwg7vn@bender.morinfr.org/ .

The issue went in fact back to 6.0. The fix was applied upstream and
then backported to 6.14.2 already. Can you backport it please as well
down to the other stable series, at least back to 6.12.y it goes with
applying (and unless I miss something fixes the issue, we
cherry-picked the commit for Debian trixie and our 6.12.y kernel in
advance already).

For going back to 6.1.y it seems it won't apply cleanly, You,
Christoph might you be available to look into it to make this
possible?

Regards,
Salvatore

