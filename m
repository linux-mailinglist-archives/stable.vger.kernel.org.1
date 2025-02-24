Return-Path: <stable+bounces-118942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBB7A422E7
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B547A9348
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB6A1386B4;
	Mon, 24 Feb 2025 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Itqc7o2K"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D714D28C
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407077; cv=none; b=mafUZQFD5HKQHfXsxxkKBTzspJ/HejCR2ewUqZbn8jUXnj0LZFXK1freeFfc3d2lQB60csz5fnkQ+dHCGQqspMeKoxupMo08FfxBYcN7lhqn2F1X/lu7fLwJzVD/2UO5MFrMeQQFiCPeICucML0hvlrgqQPqvXQunN1UUpNpj1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407077; c=relaxed/simple;
	bh=FE1CWMi2CvPnvoketKsYWYlZ+VV76x1gP9YK33cjJrs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d/IctcXS8fvVTtkEiKpROmRuQsAYg4BNnVSqCb2e4qpoMqWXTgMHuWxX6EjlJ2+M7Kozj51Zj8QuFFqRHZa+7bQNz/J9UpuBL5AmAG6AHkg/Oz23ct3fsYxNcu/jDmnb1ubDP2GzTOND90zCmJKQsNew+FnMLTpeo0W4TCxBpaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Itqc7o2K; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JT5nI4XOfZ8xYdvgJxo/xc/goWo7FZySBnJH86XdU1Q=; b=Itqc7o2K3EWNFNg/9dNvuDhCnD
	1IL97IWawWWgKdIfpB/a3aqxrn85CaHbud8WQSbNQgGCUL1AwsYy+c5Y/5ADiZpwXeSx4yEjMe9Ho
	CDvV2cCl7D6jIwapkt40y+a4+8QXFUhhscHJBLRhC988M9E/WSnUf/cjlr8r2aXds6DM3p+7KWTkL
	Fs1Ekl8rvSy5n9UNA57pg/ElKIsntK8kwK1pzroBomdbk7ARwVQj5zWM0bf44fuqf1lxMuK9rF/5N
	6qjuekNWHMr2EIUuQa5EoyCsvnOhMZmf5wD88OP0ukaimXw9BoqVxPAiV7/Ifiq8jfx5qB/d6j7W+
	6raZtvuA==;
Received: from 253.red-79-144-234.dynamicip.rima-tde.net ([79.144.234.253] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tmZNi-00HX75-SS; Mon, 24 Feb 2025 15:24:32 +0100
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, bigeasy@linutronix.de, revest@google.com,
 kernel-dev@igalia.com
Subject: Re: [PATCH 6.6 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <2025022454-dislike-unengaged-37e5@gregkh>
References: <20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v1-0-de5d47556d96@igalia.com>
 <20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v1-1-de5d47556d96@igalia.com>
 <2025022454-dislike-unengaged-37e5@gregkh>
Date: Mon, 24 Feb 2025 15:24:32 +0100
Message-ID: <87ecznzahr.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Greg, thanks for having a look at it.

On Mon, Feb 24 2025 at 14:55:36, Greg KH <greg@kroah.com> wrote:
> You did major changes to this and you didn't sign off and explain what
> you did differently from the original commit?  You know we can't take
> that...

Yes, I needed to do some manual adjustments to the original upstream
patch in order to apply it to stable... and I just noticed that I
skipped a couple of lines in one of the chunks. My fault.

Except for that, which I'll fix in v2, I didn't introduce any functional
changes to the patch itself, that's why I didn't sign it or explain the
modifications. Except for the changes in the context (and that poorly
edited chunk) the lines introduced by this patch and the upstream one
are identical.

In any case, I'll make the required fixes for v2 and I'll try again,
this time explicitly mentioning that there was some manual work
involved.

Thanks!
Ricardo

