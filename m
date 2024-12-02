Return-Path: <stable+bounces-96058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AABDF9E04F1
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B77169491
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51BC204F82;
	Mon,  2 Dec 2024 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ6MXjr5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65506204F7E
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149622; cv=none; b=IYQTp334WYMzepfG1QSf4q+Lei01Amph+06iPRfDh5b+tCfFq2scBHL/3dXxKHFSbXpweCnGuqg7UwpNux1lCSL4TD0ye5SvymAX5uGT8dMF95EfgHjLXDWCw48SopK+uEdSeCQp0acFLU1YuZHwRFSY0Uhjc0TnkePhOuIRNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149622; c=relaxed/simple;
	bh=DbXJcX2C68bqehnYYLN0S4urAx2tEO9RzFgj9y/KcEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7YZVJefakozhcFkZklMaMwNbWro5riv0ZG2gpptgYe6w+4a5e7/JEFh24zuGVlE7m2Odn+fG3MiQqnSHmva1ns/oePYTFzeYw1AMs6gUWG+4RHG7SvAH3IEfe3nttNRtv7vrxlj9DzKJ1ddLAwKmfBGXV96aXxHOy6i6V5r0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ6MXjr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1AFC4CED2;
	Mon,  2 Dec 2024 14:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149622;
	bh=DbXJcX2C68bqehnYYLN0S4urAx2tEO9RzFgj9y/KcEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQ6MXjr5C+CGOf36tuGvG/egxBOrVXz+HR7cr3DiZVsEna5+0G8aT2H1iGXQK2y/L
	 YNUGxN7w2mvkTbRdELRXOVBD9EgYH5SuLffglA8qIS1D5Vv7RjL2UIFStmL2UjmZy1
	 Uk54lckMI1NdOd+WmSCC35EqLu8+rfvreU1C2SfJk8l2Pxon4Vv8eyY8e/RvLJZafu
	 518c13wC55H+YcpXz/Wp1uX9U35j31hw43AexGPN2sd8Xoe5f6z5LS3o3VWJAmKH5i
	 nS0TCRcuml6DnWpwZVltlvrN26jEgmzzgn8AEjPmph/5LkULRkFgFfQPu1WkLX9fjl
	 M5kIEcQX0aEtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Siddh Raman Pant <siddh.raman.pant@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 2/2] cgroup: Move rcu_head up near the top of cgroup_root
Date: Mon,  2 Dec 2024 09:27:00 -0500
Message-ID: <20241202081938-d8b300678202dad5@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202111024.11212-3-siddh.raman.pant@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: a7fb0423c201ba12815877a0b5a68a6a1710b23a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Commit author: Waiman Long <longman@redhat.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: f3c60ab676bb)
6.1.y | Present (different SHA1: 0e76e9bb1d8d)
5.15.y | Present (different SHA1: 9405d778a49a)
5.10.y | Present (different SHA1: 4abf1841680f)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

