Return-Path: <stable+bounces-125750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B34A6BB6F
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 14:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA9E189F542
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 13:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914132248BE;
	Fri, 21 Mar 2025 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="0ha4hkew"
X-Original-To: stable@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A346C1F8F09
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562495; cv=none; b=XpeYMwJVGwL03O612nw+0PIo8167f4LroDjjSR4MgAnb6NeLu7Hi+3i2NGzJU4dhCS38+IVX9HNuje/j4vVU4PnGBaH869pDE1A/PEAT4pzpQJ5NUCplgsj4DTccd2ITp1Zp21pwnVJdp/UdMe58MhOA3amjWuJ4vJihuEjGXY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562495; c=relaxed/simple;
	bh=otWxX9wRt2P0VpmqZic1q5LY41p+eMQn82/c3tJh078=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=GwX1RLnj2alHEKnevXWR4iJJalYvqciXGLFxZJGn8IcrkMj8bjHKwxpKcc9IKGDBzAzMCut/cRuNSTfZUuvzz9lPGbErdB6T/iTUYA7CK//vBRJfKhlrYcZrvu4mYFpmAiCeJ5O8bZSn/TvJItR6Tjg7A9AEcSm3HdOI/TZOxEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=0ha4hkew; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:Message-ID:Subject:To:From:Date:MIME-Version:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e3Kt/yRz2W8/ucIcA+BjHBa7Yewvv7wg+EEC+DtagM8=; b=0ha4hkew6/vWjukmonmcF/YeUY
	40uVxArqAFd7hNXCRC1+d1CGOYrryzJS2/eiIfAdaihhUXIlbzg0E0olR8UFhsxjNIQeFOYt0W8Hj
	poPeCKmo2AW3X3ySNRDvXdxlKjcOm92/11i0T3lyMqtSTVwjMasuHRw34aERNGDRTDfN13OrqjEVv
	Qm5y0pPxum0INX8WWL29ZqnWGDUsALNYlRXWyloyoJZgl2q0XP8EcQ8b00TMEE/ijjOwbiaLYWGac
	vUmiunx7KnH8hP4excRjTOY562PfffccBLGt2CKVAX1ninDUzksQJzF/Jy6IP5QforbMtTrFA+5nx
	zg3UGdVQ==;
Received: from ipa12.colo.codethink.co.uk ([78.40.148.178] helo=webmail.codethink.co.uk)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1tvc6U-001JgO-FA
	for <stable@vger.kernel.org> ; Fri, 21 Mar 2025 13:08:03 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Mar 2025 13:08:03 +0000
From: James Thomas <james.thomas@codethink.co.uk>
To: stable@vger.kernel.org
Subject: BUG in LTS 5.15.x cpusets with tasks launched by newer systemd
Message-ID: <d3bbf1997bae30253a7be05c7e2a06fb@codethink.co.uk>
X-Sender: james.thomas@codethink.co.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: james.thomas@codethink.co.uk

Hello all,

I encountered an issue with the CPU affinity of tasks launched by 
systemd in a
slice, after updating from systemd 254 to by systemd >= 256, on the LTS 
5.15.x
branch (tested on v5.15.179).

Despite the slice file stipulating AllowedCPUS=2 (and confirming this 
was set in
/sys/fs/cgroup/test.slice/cpuset.cpus) tasks launched in the slice would 
have
the CPU affinity of the system.slice (i.e all by default) rather than 2.

To reproduce:

* Check kernel version and systemd version (I used a debian testing 
image for
testing)

```
# uname -r
5.15.179
# systemctl --version
systemd 257 (257.4-3)
...
```

* Create a test.slice with AllowedCPUS=2

```
# cat <<EOF > /usr/lib/systemd/system/test.slice
[Unit]
Description=Test slice
Before=slices.target
[Slice]
AllowedCPUs=2
[Install]
WantedBy=slices.target
EOF
# systemctl daemon-reload && systemctl start test.slice
```

* Confirm cpuset

```
# cat /sys/fs/cgroup/test.slice/cpuset.cpus
2
```

* Launch task in slice

```
# systemd-run --slice test.slice yes
Running as unit: run-r9187b97c6958498aad5bba213289ac56.service; 
invocation ID:
f470f74047ac43b7a60861d03a7ef6f9
# cat
/sys/fs/cgroup/test.slice/run-r9187b97c6958498aad5bba213289ac56.service/cgroup.procs

317
```

# Check affinity

```
# taskset -pc 317
pid 317's current affinity list: 0-7
```

This issue is fixed by applying upstream commits:

18f9a4d47527772515ad6cbdac796422566e6440
cgroup/cpuset: Skip spread flags update on v2
and
42a11bf5c5436e91b040aeb04063be1710bb9f9c
cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly

With these applied:

```
# systemd-run --slice test.slice yes
Running as unit: run-r442c444559ff49f48c6c2b8325b3b500.service; 
invocation ID:
5211167267154e9292cb6b854585cb91
# cat 
/sys/fs/cgroup/test.slice/run-r442c444559ff49f48c6c2b8325b3b500.service/cgroup.procs
291
# taskset -pc 291
pid 291's current affinity list: 2
```

Perhaps these are a good candidate for backport onto the 5.15 LTS 
branch?

Thanks
James

