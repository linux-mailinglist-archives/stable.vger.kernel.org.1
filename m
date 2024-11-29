Return-Path: <stable+bounces-95840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2FA9DECDE
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 22:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8777B20AC9
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7A8189BAD;
	Fri, 29 Nov 2024 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nnTjujDb"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6700B155300
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732915252; cv=none; b=aThga7RIMJl4ZRbka85QW8ofb8Vdi7u+6jRKGRjofDOQ5mBn4Y7np5A7QFgMoIT1/rq8P7Y6ED3xvXC8NsqKM31MWfOYPho1mGJKz/lK8LsB4YyssBMha+5iKehT3UU1idDRfQthytYO8bgoKh/9thocpw47tJU6T9a0yuJ+Vug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732915252; c=relaxed/simple;
	bh=/OIS65UgVyCsbYd4J0PHLr/KtC6EVuk2tik4ryOqy28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdO2qg/4AFB3Z/zvhFUsIb3QUFB2V+Anl4JdZ0uuG07UD0En5CGIr1poKKLUXA5sfyVNAXEbBi1sNoZP2ex7C9cwdCVI7aGkd6IVhRtPFtG7PvtIHiNdCxQs3gbDkqiOMEgo1uOeNMMPdvsbywa8Jz2l1bJzs+FGoX78qscUdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nnTjujDb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.80.160.39] (unknown [108.142.230.59])
	by linux.microsoft.com (Postfix) with ESMTPSA id F1789205307D;
	Fri, 29 Nov 2024 13:20:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F1789205307D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1732915250;
	bh=5d+ZyJYYnXStYtwE+mk37XMR1YxN9NgIxHaoVNulVAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nnTjujDbjr/UpS9OB2ML3/gmoAvJwsyhUv4XsBtqqp5+t0Oh6xYxMxEyaCqDWyWe9
	 IkRVyu/CkBV1QqHerFc3oSc1nfkzOMQtCZFmbB916xvQpuTpR/B9oVU4+a2uN8b3HH
	 PCFT8ksXEx6zVdY9/1lEjvMrsGiqSKz+Rd/C9GBY=
Message-ID: <95cf11dc-6771-4a53-9c34-20ee27bfeaa2@linux.microsoft.com>
Date: Fri, 29 Nov 2024 22:20:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15] kernfs: switch global kernfs_rwsem lock to per-fs
 lock
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Sasha Levin <sashal@kernel.org>, Tejun Heo <tj@kernel.org>
References: <20241129113236.209845-1-jpiotrowski@linux.microsoft.com>
 <2024112923-constrict-respect-a0a6@gregkh>
Content-Language: en-US
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <2024112923-constrict-respect-a0a6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/2024 13:12, Greg Kroah-Hartman wrote:
> On Fri, Nov 29, 2024 at 12:32:36PM +0100, Jeremi Piotrowski wrote:
>> From: Minchan Kim <minchan@kernel.org>
>>
>> [ Upstream commit 393c3714081a53795bbff0e985d24146def6f57f ]
>>
>> The kernfs implementation has big lock granularity(kernfs_rwsem) so
>> every kernfs-based(e.g., sysfs, cgroup) fs are able to compete the
>> lock. It makes trouble for some cases to wait the global lock
>> for a long time even though they are totally independent contexts
>> each other.
>>
>> A general example is process A goes under direct reclaim with holding
>> the lock when it accessed the file in sysfs and process B is waiting
>> the lock with exclusive mode and then process C is waiting the lock
>> until process B could finish the job after it gets the lock from
>> process A.
>>
>> This patch switches the global kernfs_rwsem to per-fs lock, which
>> put the rwsem into kernfs_root.
>>
>> Suggested-by: Tejun Heo <tj@kernel.org>
>> Acked-by: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Minchan Kim <minchan@kernel.org>
>> Link: https://lore.kernel.org/r/20211118230008.2679780-1-minchan@kernel.org
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
>> ---
>> Hi Stable Maintainers,
>>
>> This upstream commit fixes a kernel hang due to severe lock contention on
>> kernfs_rwsem that occurs when container workloads perform a lot of cgroupfs
>> accesses. Could you please apply to 5.15.y? I cherry-pick the upstream commit
>> to v5.15.173 and then performed `git format-patch`.
> 
> This should not hang, but rather just reduce contention, right? Do you
> have real performance numbers that show this is needed? What workloads 
> are overloading cgroupfs?

System hang due to the contention might be a more accurate description. On a
kubernetes node there is always a stream of processes
(systemd, kubelet, containerd, cadvisor) periodically opening/stating/reading cgroupfs
files. Java apps also love reading cgroup files. Other operations such as creation of
short-lived containers take a write lock on the rwsem when creating cgroups and when
creating veth netdevs. The veth netdev creation takes the rwsem when creating sysfs files.
Systemd service startup also contends for the same write lock.

It's not so much a particular workload as it is a matter of scale, the cgroupfs read
accesses scale with the number of containers on a host. With enough readers and the
right mix of writers, write operations can take minutes.

Here are some real performance number: I have a representative reproducer with 50 cgroupfs
readers in a loop and a container batch job every minute. `systemctl status` times out
after 1m30s, container creation takes over 4m causing the operations to pile up, making the
situation even worse. With this patch included, under the same load the operations finish in
~10s, preventing the system from becoming unresponsive.

This patch stops sysfs and cgroupfs modifications from contending for the same rwsem,
as well as lowering contention between different cgroup subsystems.


> And why not just switch them to 6.1.y kernels or newer?

I wish we could just do that. Right now all our users are on 5.15 and a lot of their
workloads are sensitive to changes to any part of the container stack including kernel
version. So they will gradually migrate to kernel 6.1.y and newer as part of upgrading
their clusters to a new kubernetes release after they validate their workloads on it.
This is a slow process and in the meantime they are hitting the issue that the patch
addresses. I'm sure there are other similar users of 5.15 out there.

> 
> thanks,
> 
> greg k-h

Thanks,
Jeremi

