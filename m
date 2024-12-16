Return-Path: <stable+bounces-104306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A24D9F288C
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 03:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF37B1885D14
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 02:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392FA450F2;
	Mon, 16 Dec 2024 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Jx4KE4WK"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E2847B
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734317946; cv=none; b=p5z7tbE3NFFzte7239Kw8AxLgCQqkahRVhEG6QKDEd0IGRKz5Q/E3ggLEqfdLCNvIP4qpaTP5cDi7+DtOe9eauKG/VNqcZ8uD4Up5X93ffRks8VIbwtV3ZTQNYa1DnRb2r/t42kqTF/ZI4r3244XaWOF2KyaErJSYnRKrfRLQ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734317946; c=relaxed/simple;
	bh=oRg/J94eTfjNlSpqnBL8YlCcwuUSaH5Y2FVfIOF8K+s=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=d94c8w8F33WHnOgxKNI64xwG4xbmVNUb8JH9XWGEbiV/upQK+RydieBybm0L/yHinX1MnjBRcvp7qsbINxc6CyX0sOtgdneMl+3/Nceg2pLlN2V0RDYa34m3LheFyZW1+LxlYGlZhbrs/iEuyWDrTGuhTGUO0NZgerEh8H4KwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Jx4KE4WK; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b1601e853eso292519785a.2
        for <stable@vger.kernel.org>; Sun, 15 Dec 2024 18:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734317943; x=1734922743; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKP6nHWluS7O1xJzbUle6DGcaM+38kjCKwlkf+H4O+g=;
        b=Jx4KE4WKznFV9Xryab0wqMwgD3rzvYLUzvEa8vVhFA4gf435HLrwwZupPkFBiTGJKp
         zRh3/WwoJQTvpd18K0i23jSTESR0XTFC2TZOBQMhdgLV6ukuxsZCFc5/q0xfAhdCNuXC
         h+7BoRtjyt+0jQ8oqIuRBgGUpDBgKV+WRW4u7809PBo8NlAXNQGIMe+Aho1NETkU4RZu
         Lsvo6VH4mihpnrAFntAngGERh5uUimZa29wKtiZXRpxmxVhmOHicWRZdAkNgDo0Mw/Ut
         H5P9W2p684YnFbyxdLrYcmobm2o9gkLHW/PtCnIq0QZLkHWC8K2NzMYRTZBd0U1Kc4Ka
         ChTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734317943; x=1734922743;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vKP6nHWluS7O1xJzbUle6DGcaM+38kjCKwlkf+H4O+g=;
        b=ggJNwYOWDDd1fKxi5ueEnGD8ljjXRidvwcAhQFTCyPwWYduy2NdJz4ni+iM44T+Cv9
         MBKolrmb8P2wg/EybloFHcahsIbCsirOK2KjqgD3EUk3QVa2iFPuuhEfnyrw5l4TpJ9s
         Qv9dgGDkZCQoyQBdYCE4CnESczBpPA2B4NKYkvlf2GM3Evi7uGbXRM6wW3TsR7DnEMYt
         TLlOl8Q/yYWPxpnHc3S8C6Z6oV6qdw6B99RsJXcGwnO4elg8e6F3hFvLgb2OMBoyopKN
         NH7FcPUj7/fQedeqk27Ro+R3DAnbt5AqpdjxhScZ7dOI3591IR2Dzcc0FHCN+vqOl5rw
         AgyA==
X-Forwarded-Encrypted: i=1; AJvYcCUBNQwaS1UuAuv8Df3YHAXn8HVTvujI4p6BknFlGSqVpkLf0ARynBMI111N6PdI9c0xcLtgi20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7jOc79W+Uon3zKpu4AOYgRVYjsnc8MnnOC0IXsBlaq26nv5sx
	EF0ROD5HOtgaopUbvy3yRdW15vpzCETITVymYiyxY2hjT5sG2fA/pYTpF+ua0w==
X-Gm-Gg: ASbGncuWVDb7rRzRKJS/z/FX5Ym8Nt5KA2VUa8cCwDNeH1pjQrs8a52DQkOit92Q7A5
	z/9X/yv1tJsj35vaodg5KtZCaGHU4Lom/Br+ToIk8C7iM/noQKnjGTu9UtQizBUJiV+6JNTcUcL
	Eq9tr9AwtPE2I8Xd5lK6DIzCpKkRcgDrhWP5ZJtJnAGtVx+godZQHW/EMkMamwFdTBu+6GkXeyz
	FeFea5alQsWg8OFvVdjFCcG0I7YYJda6TU7wbazEMmG8QV8uyQ=
X-Google-Smtp-Source: AGHT+IGMGxkReijwR9eozlTmclt00/3usEeA5lUTtxSR8bPChvJHxwj8qzgZmIUFluwOwB/Zg+ElLA==
X-Received: by 2002:a05:620a:2716:b0:7b6:d327:cc47 with SMTP id af79cd13be357-7b6fbec77a7mr1554405585a.8.1734317943256;
        Sun, 15 Dec 2024 18:59:03 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047cd0b0sm184484485a.29.2024.12.15.18.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 18:59:02 -0800 (PST)
Date: Sun, 15 Dec 2024 21:59:02 -0500
Message-ID: <b1ef65626191549de8d6508f82902863@paul-moore.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241215_1918/pstg-lib:20241215_1918/pstg-pwork:20241215_1918
From: Paul Moore <paul@paul-moore.com>
To: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Cc: "=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, "=?UTF-8?q?Bram=20Bonn=C3=A9?=" <brambonne@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] selinux: ignore unknown extended permissions
References: <20241205010919.1419288-1-tweek@google.com>
In-Reply-To: <20241205010919.1419288-1-tweek@google.com>

On Dec  4, 2024 "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com> wrote:
> 
> When evaluating extended permissions, ignore unknown permissions instead
> of calling BUG(). This commit ensures that future permissions can be
> added without interfering with older kernels.
> 
> Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> ---
> v2: Add pr_warn_once, remove other BUG() call for key.specified
> 
>  security/selinux/ss/services.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Merged into selinux/stable-6.13, thanks!

--
paul-moore.com

