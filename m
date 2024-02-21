Return-Path: <stable+bounces-23253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBB785EBDE
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 23:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E1028517F
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 22:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1566733F7;
	Wed, 21 Feb 2024 22:34:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out28-56.mail.aliyun.com (out28-56.mail.aliyun.com [115.124.28.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BCE81ABA
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554891; cv=none; b=KExU/+oKzD1cpDwFEP40lWKkv4I2oG0r2X03WYTixVbq9cdmUyrcSjcfwcNmYr6sVkFTLORafQvY3WMYIXhAaJB5BDTCQGnlkx+8TZEgfWC58tle+Iol5QDSwI7VG8rE0Qfv5P9xhwGTre0CRZvszQOGGDIVTsnJcARQG4IG45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554891; c=relaxed/simple;
	bh=Oput9+z1s8a17hFVDYGrHltO5nBaI5cr4eCCcitGUc8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=HGRGSd5w6uAEA4Zo7+FJfXcHeqHSUdePTfMGLZ7KJmr1NxoUAgzWzBLDC77SlSX3aLXMVi1MEXQdN9kmspFvI0UlXNQ7w0Dx2ug931jvjaZBSur77+LkxyI1BsTavc2jqdfF2H/BqiTTY9eFQuAUQq+iT1NlU5twvHpbvUlTzro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2776432|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.159163-0.00167879-0.839158;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.WWYDqlO_1708553949;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.WWYDqlO_1708553949)
          by smtp.aliyun-inc.com;
          Thu, 22 Feb 2024 06:19:10 +0800
Date: Thu, 22 Feb 2024 06:19:12 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.15 111/476] NFSD: Modernize nfsd4_release_lockowner()
Cc: stable@vger.kernel.org,
 patches@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>,
 Sasha Levin <sashal@kernel.org>
In-Reply-To: <20240221130012.081046577@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org> <20240221130012.081046577@linuxfoundation.org>
Message-Id: <20240222061911.6F1A.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.05 [en]

Hi,


> 5.15-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> [ Upstream commit bd8fdb6e545f950f4654a9a10d7e819ad48146e5 ]
> 
> Refactor: Use existing helpers that other lock operations use. This
> change removes several automatic variables, so re-organize the
> variable declarations for readability.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Stable-dep-of: edcf9725150e ("nfsd: fix RELEASE_LOCKOWNER")
> Signed-off-by: Sasha Levin <sashal@kernel.org>


"nfsd: fix RELEASE_LOCKOWNER" is yet not in 5.15.149-rc1?
or I missed something?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/02/22


