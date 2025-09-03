Return-Path: <stable+bounces-177637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1763CB424FB
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 17:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9359B1888CC9
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A28BA42;
	Wed,  3 Sep 2025 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LK2mYxX9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137C718EAB
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912829; cv=none; b=BUVuIfKPN/Qqn7bzNVJ7rEeLRcVohttIrLJguxrEQWeWg0sql4n8KnOwCr8llGVRXdKY2rk0dtZ4HOZQnW6KZS/J0vEYYbA2KKgPrx3uJ2/IjMzP5oDkEZYASHndYuw/xibv5DugIGwErQ0+fefTpEf2HLrjp9NtnQv0OMPn+cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912829; c=relaxed/simple;
	bh=9InNAQJ7gpEOtC9tdOkNJOUGLaAu3PFitzqpLxBGzQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orY+BgFjyIOhvw6n7M5CABg7g9WqKPI1+XkXKE3bVKb300cI7+S3o8M1mrMf68wht8n7PywdSSF3rTATaqzbFXUp3prP4UN/Twy/fstATVcBzecGwdVViICqFfGum58NUYR9i5z2r8XFSgO+CCBqiAdA6GpvGlDTwfXXX4hDyEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LK2mYxX9; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b3d3f6360cso461761cf.0
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756912826; x=1757517626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp+J43QzeSA3ipi35Z3UrosRjV5eUSYx6Z1a047sK5w=;
        b=LK2mYxX9aN2Y/Bz9AEOM1wZyw18c9kIqPCMlOJQzgt864bWbiP5JigA8Oc/6bvVm5k
         C/q1n4aEKdhFihCBDOFP+bMR+o4nJEn5PKERYiEgKuevkSk9nRjv4tkcM88NvzVFy/0i
         +trrL75rTZ1PObcPfe7V2DNHwavHac53/wowI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912826; x=1757517626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jp+J43QzeSA3ipi35Z3UrosRjV5eUSYx6Z1a047sK5w=;
        b=lf4eNkpAJp+/9PqFXh1q+vVrG+05ABk+G214hF06kOFYUMld1Oqe1cGt1k0gShp/6d
         ljtCe8+CPErxstvbMiIQy34AlOUbSYw1OCgQyaz3zxDb6LVBS+l47iOUkd/oPv3eLSUC
         0YtzNWBWurPph3S/DASgNHBi5KU4pnj1fuEuLfLiVF1cetno1TLIpVlgr2/0huRk063P
         d6i0T2bgUnbm0MVZiG9p+QJ6AbbqavwbqaXQ0xFpJ31g6HuTt3vTWwjZeURdHJs6DQ0h
         w7Maa+m2p9l1pc1IpuIwhL/IPG7zedGLX0Sc+0SH5BKmI7HjrNH4/xaeLu/aFFAt5Mix
         I/SQ==
X-Gm-Message-State: AOJu0Yw4MG2p0EgZ3Af+nRvvCVNgYSxlsfF3vebDktTuK79IA37J850V
	5Xmn45LRFJ8XnSmYwoVl1bGg2Fmgbs29+0tNargJqejWCIUR8OOH/F6B5QkLJz7st6y6lV9jl2d
	xMBKtpcdvBjUYJbyb4UGvqYT5gMJMF2nXoQm9yIPDSQ==
X-Gm-Gg: ASbGncuWfAWYkxQcHhk9zFkCDxsDLOQYvu+YzMeiqkCL1/nJSC+0DrORFgnsCO9Zaf7
	O8RRETblW/Uo4CMseglvsJ7DfLCoOOjyBFgJJhHujEsEEe9lVZ4SH+2QK/G+QTiSgEstca87MwQ
	hfxgDQz5TExO3o/vQpE9lsPKGtOYlAvFytlvb9bx5cdVivLns0/BaDWYNVGRCAmtoTRWXf0MT6p
	n/EA/WNVQ==
X-Google-Smtp-Source: AGHT+IF5fF+jyyHqxnhzSEalVmV75mrF2TBJ09+DMCRFs7FSnX7qLRnanSbR82YN+NfxpfT2KoNv0m6fW8eFg43Sck0=
X-Received: by 2002:ac8:7f0d:0:b0:4b2:8ac4:ef5a with SMTP id
 d75a77b69052e-4b31dd791f2mr201676391cf.81.1756912825001; Wed, 03 Sep 2025
 08:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs> <175573708568.15537.7644981804415837951.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708568.15537.7644981804415837951.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 3 Sep 2025 17:20:13 +0200
X-Gm-Features: Ac12FXxx2ejnJZj2Eflz9uh0Pqu4agB2MWu9zI8tgTQJ7AhyqJpcEy-q1wBv9Xs
Message-ID: <CAJfpegv2xzmMCN9Gvy=4Z-vC-ENM-4MoKRwoQrC39jfoa2q-Jw@mail.gmail.com>
Subject: Re: [PATCH 1/7] fuse: fix livelock in synchronous file put from
 fuseblk workers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: stable@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 02:50, Darrick J. Wong <djwong@kernel.org> wrote:

> Fix this by only using synchronous fputs for fuseblk servers if the
> process doesn't have PF_LOCAL_THROTTLE.  Hopefully the fuseblk server
> had the good sense to call PR_SET_IO_FLUSHER to mark itself as a
> filesystem server.

I'm still not convinced.   This patch adds complexity and depends on
the server doing some magic, which makes it unreliable.

Doing it async unconditionally removes complexity and fixes the issue reliably.

Thanks,
Miklos

