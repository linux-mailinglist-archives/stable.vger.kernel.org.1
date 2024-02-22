Return-Path: <stable+bounces-23330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC80485F9DC
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 14:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A45AB23CA1
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3117C4652F;
	Thu, 22 Feb 2024 13:33:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out28-68.mail.aliyun.com (out28-68.mail.aliyun.com [115.124.28.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504C12F5B5
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608795; cv=none; b=ki0KHH0/97DU11y/pg8qOVhKWgw4T+44Rt6Dzf/7EXZC7keh53BUXK7XKe6JiHMKCHOe9PBAuC02cdSpBk5DFcqt0BJfo9hJcqh+qGIEIyAr7bsHy17Fs/plUv0yp2u4Fl9dvydzRZ4wr9ULFLkhhfAjiJTaGpMRoc1RNR2iMxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608795; c=relaxed/simple;
	bh=7dY0J6tWUfZDjRXqq+3RTmoIss7uMaGRscXZvaR85HE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=n3CvJusPGyVJeU1ErB3NtqvETKU6x5wv0LGrmc5tkVgWuJGdvgsJ3P02BBYak7UUigJNzBPXTzRGodiGC8JZZ6i0lGd0ybyQ+JBK1FXIP5G5FwvzumZKDOvHn8O3dnKk/6N9E3SuFecrhT30E7CTDtKvSIF8ESeqClbSoBRc6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09046134|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.082199-0.00234652-0.915454;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.WX5xhwP_1708606924;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.WX5xhwP_1708606924)
          by smtp.aliyun-inc.com;
          Thu, 22 Feb 2024 21:02:05 +0800
Date: Thu, 22 Feb 2024 21:02:05 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.15 111/476] NFSD: Modernize nfsd4_release_lockowner()
Cc: stable@vger.kernel.org,
 patches@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>,
 Sasha Levin <sashal@kernel.org>
In-Reply-To: <2024022213-salami-earflap-aec9@gregkh>
References: <20240222061911.6F1A.409509F4@e16-tech.com> <2024022213-salami-earflap-aec9@gregkh>
Message-Id: <20240222210204.4F83.409509F4@e16-tech.com>
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

> On Thu, Feb 22, 2024 at 06:19:12AM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > 
> > > 5.15-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > > 
> > > [ Upstream commit bd8fdb6e545f950f4654a9a10d7e819ad48146e5 ]
> > > 
> > > Refactor: Use existing helpers that other lock operations use. This
> > > change removes several automatic variables, so re-organize the
> > > variable declarations for readability.
> > > 
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > Stable-dep-of: edcf9725150e ("nfsd: fix RELEASE_LOCKOWNER")
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > 
> > 
> > "nfsd: fix RELEASE_LOCKOWNER" is yet not in 5.15.149-rc1?
> > or I missed something?
> 
> Good catch, you are correct!  I'll go drop this, and the other nfsd
> "dep-of" commit in this queue, and in the 5.10 and 5.4 queues.

Will we add "nfsd: fix RELEASE_LOCKOWNER" to 5.15.y later?

It seems that at least 5.15.y need "nfsd: fix RELEASE_LOCKOWNER".

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/02/22


