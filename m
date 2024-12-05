Return-Path: <stable+bounces-98724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC679E4DF0
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EE31680D6
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2424B1AB517;
	Thu,  5 Dec 2024 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YsJncUg1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8429B1AAE10
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382358; cv=none; b=CiSzguj8azpDjO62QzRcZh4quekO5oqJQR1woBUfeFyydBKRaOg/0WrOcwmzUkYJjvzXCrcPk7tTuD7eZltcpWjV5+54WZA9UNk9BpIys/Ncl3N4xSGKLjEoTQiDrqNITXsSS5JKpcMX4zjjNobpI/HBukZvIUI2uoMN/MhtVQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382358; c=relaxed/simple;
	bh=zjJgxmY2y1deqyKR6Stt9PT+fsWAX390mIy9QNV8za8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgDMHcX4k9CD64FBoysOYrjZ84aqaCpVykbAgznwmF/xq8IJ9qKwZ/qMUzIBoQvkuqWJMNlCFT5solP7IEOjlphluwXxsvWu7jk0/Mn9HdBVwhRGRdJg/gDW6FNrhDhEZ5LwKfaMD4KO30n3MQPTpgRYuiMDBMNzGE3Jsdss9zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YsJncUg1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72590a998b4so1194789b3a.0
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 23:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733382357; x=1733987157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pnVjnK/k6GXXnPfVx21d5+g3wu4ThlrDFA24wTktnFw=;
        b=YsJncUg1a1f6U1pWsuQgbpsAxT8+oIrE0rzyWKTp8gT/FSob/b6EzyyycQe0BbTJE9
         ZWlqWhSXG/rlcmo+XyLQ06rTNJlSGO1tOfNG9wAf+fg6tSHr2ZVuuQjL/hQMeGDcC7Yd
         U1FTktsfhLwuAtLKuR6KTRXHYbPcEB0ND0mGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733382357; x=1733987157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnVjnK/k6GXXnPfVx21d5+g3wu4ThlrDFA24wTktnFw=;
        b=QbjWBn5i1mcgiKN9R9KPL+Bl9sXI3Z7h7weQGgUmwtOIjRQkZbluhE+CTPP9ODN8nj
         ouXgBqJVXGi9mc/YUNC4yGPozvHlvPyvQ7/4nZ8IJ93S71gzJlj9N/cxpmdE/KnnWPAK
         7T7ZE3ajrJBTJ+4+kyB1sYquKJHJb/JoZryZEITVr2/dVfxOwsmeswSE2izu8iK7v07y
         cHMpuaGnG3e7iz8M1vgKdtjSNdtttIPiDem0On132zmblYXnDx6YLqDDkgmOtn0dCIvM
         ZbMX1vGnDywyW5caP//b1MwxhsrDaMl2aUzwEmJbPdgWFdTyU+LTT+GVkHO+yiY1/DTA
         bF+g==
X-Forwarded-Encrypted: i=1; AJvYcCUpjDe65223hsJ1/1xKkdzMRhbIZDYNaSidyi3rVqnW/ZOJ0DGgBwdLu2+5DU2YccaIPeiLoMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHDRUGm2krAcLvGpf2hUZ1URZoe8vInwxDchSKjum7zHNz3asg
	I35nTGSMXIeqbl28DwncUf8cuDTY6j0bF0zq1UXgdT6g0ZX922UTGUH3Pv4w9Q==
X-Gm-Gg: ASbGnct8mf9+YweZy24Fh32KsFCgafS5Bx4AeJWBgC639d2sD+AhYZki9SA+wM56//n
	bgkpWR+6weeLcAZ7cblOAzuaYHzSGsOZbRucwYhrfLexj3y/Hkwt4gVFJdOLuOZxptgwXGm9N/s
	1RVFz5SKkckoGd1b+afiANQj0XFVpGROZbly6rIS3dZ0Dg0jmzUQoZFN1hZmYSHJ5Lwtte8bN2x
	G3oRKkHvDivbFPeWS7VAVVvpwUHXReNNm29Mr7PRHTVD69Qd5vC
X-Google-Smtp-Source: AGHT+IHmb5xrPz+rTcqYtFMLlN13EqPWRM+lusJzh9gyYi0pYOG3cg9tOPzuRPSq4iV6N8E2CP/VqA==
X-Received: by 2002:a17:902:dace:b0:215:65c2:f3f2 with SMTP id d9443c01a7336-215f3c56e3emr34471825ad.6.1733382356790;
        Wed, 04 Dec 2024 23:05:56 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:84f:5a2a:8b5d:f44f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9dafsm5958855ad.120.2024.12.04.23.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:05:56 -0800 (PST)
Date: Thu, 5 Dec 2024 16:05:52 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Desheng Wu <deshengwu@tencent.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: refuse to use zero sized block device as
 backing device
Message-ID: <20241205070552.GE16709@google.com>
References: <20241204180224.31069-1-ryncsn@gmail.com>
 <20241204180224.31069-2-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204180224.31069-2-ryncsn@gmail.com>

On (24/12/05 02:02), Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Setting a zero sized block device as backing device is pointless, and
> one can easily create a recursive loop by setting the uninitialized
> ZRAM device itself as its own backing device by (zram0 is uninitialized):
> 
>     echo /dev/zram0 > /sys/block/zram0/backing_dev
> 
> It's definitely a wrong config, and the module will pin itself,
> kernel should refuse doing so in the first place.
> 
> By refusing to use zero sized device we avoided misuse cases
> including this one above.
> 
> Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
> Reported-by: Desheng Wu <deshengwu@tencent.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

