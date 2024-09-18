Return-Path: <stable+bounces-76712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F5297BFF4
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 20:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF741F223DF
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1361817C98E;
	Wed, 18 Sep 2024 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="idT5mADP"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289051898E0
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726682565; cv=none; b=HC892++kOL5naTzczw5WFZ9LM9rRAneEvBmJEc+nZz+jekZwlj3l0Aas+4BzWQjhauDpQ90uiD+I5jxDUHoGNqKlmbejPfsZbxTtZPYJcvw33l93+R6KdKHBH5X+DJ3Ki4jl+mFbjmvOU6Gf4y5qG7Tef2yEL0Sk8qa2goq2lq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726682565; c=relaxed/simple;
	bh=eydevBGhJQWI1E04KDmItu5tvPwEG5AW7hNQ3eUI0Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MwYvFSnXqME608cQtaLGXKPd+UKiFmIB2BqXr2cLwcghX46nLYsXHNM/woDV3NHewxMzSxYAcH/Q1PzO2gInwLt4Zk3v2F42OO9gtBp6sYSqHe7zTWq8BFHV3EQJsFt1L+CCNyhLi0DTvTYSQzL9MFNjNjUCdchjCrr/lBSz+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=idT5mADP; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.15])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6EE21407851B;
	Wed, 18 Sep 2024 17:55:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6EE21407851B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1726682145;
	bh=uuGShs7iKMnmnffCNSbAsLKj+IneYBQ5SRuM2p8K3fQ=;
	h=Date:From:To:Cc:Subject:From;
	b=idT5mADPb7/MrEU/srWNQQlj4V2ImdpWoqYTAvj9viXulq+JIhXsblJm7v9JMvpHP
	 Utx02UEGar4vh/bhe9F9F2iSr+CnDFaLNE+gHyQbDFLD3xMh45m8LWhKtQ5vE25pAo
	 ew4+K61uU3Pfx+PAROpti4oELcy+pU3eBalzwlZA=
Date: Wed, 18 Sep 2024 20:55:41 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Cc: lvc-project@linuxtesting.org, gerben@altlinux.org, dutyrok@altlinux.org,
	kovalev@altlinux.org
Subject: Request to revert "wifi: cfg80211: check wiphy mutex is held for
 wdev mutex" from 5.15/6.1/6.6
Message-ID: <20240918-d150ee61d40b8f327d65bbf3-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

Upstream commit 1474bc87fe57 ("wifi: cfg80211: check wiphy mutex is held for wdev mutex")
has been backported recently to 5.15/6.1/6.6 stable branches. After that
we started seeing numerous lockdep assertion splats in these kernels
originating from different parts of wireless stack where wdev_lock() is
called. There is also a huge pile of them already found in Syzbot [1,2,3].

Digging more into the issue it appears that the blamed commit is a part of
a much larger series [4] with locking cleanups and improvements for the
whole wireless subsystem. The series was merged at 6.7.

The cover letter for the series says:
  There's a kind of pointless commit in there that adds some wiphy
  locking assertions to the wdev as an intermediate step, I can
  remove that if you think that's better. We ran with it at that
  intermediate stage for a while to test things.

So backporting this commit to stable branches without taking the series as
a whole is pointless and just leads to bogus lockdep assertion splats
there. The series itself is an improvement and cleanup work and therefore
is not considered as material for old stable kernels.

The solution which comes to mind is to revert this backported patch from
the affected stable branches.

Namely:
- 5.15 https://lore.kernel.org/stable/20240901160825.013135421@linuxfoundation.org/
- 6.1  https://lore.kernel.org/stable/20240827143842.546537850@linuxfoundation.org/
- 6.6  https://lore.kernel.org/stable/20240827143846.794100356@linuxfoundation.org/

The intention why it was suddenly backported to these branches a year
after merge-to-upstream is not clear actually: there are no stable or
Fixes tags in commit message, and I don't find any public request for
explicit backport on mailing lists.

Please let me know if you can revert the commits yourself or I have to
prepare and send them to you.

[1]: https://syzkaller.appspot.com/bug?extid=310a1a9715fc1c9ead61
[2]: https://syzkaller.appspot.com/bug?extid=b730e8b6bc76d07fe10b
[3]: https://syzkaller.appspot.com/bug?extid=09501cf606ec2823fafa
[4]: https://lore.kernel.org/linux-wireless/20230828115927.116700-41-johannes@sipsolutions.net/

--
Thanks,
Fedor


