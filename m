Return-Path: <stable+bounces-216289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Sa8cMZ5nj2lHQwEAu9opvQ
	(envelope-from <stable+bounces-216289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:04:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 373A9138CC4
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 077033030ED6
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE3A239E80;
	Fri, 13 Feb 2026 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gZp+xvcv"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650A3C2F;
	Fri, 13 Feb 2026 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771005851; cv=none; b=qrvDb9SKfOHFBQXug3iXOitYk9z0VDeDIbPkME9gB0NVIXkRZD4YJlJg3QkP/Z/uKy4/Ce9Z1aD1RGSgDLgIb/zxiTvjmEqa2e01H35qkyMOIWi5UEwr4q7Rn6lONm/YwWx0CNd40bPQyr789GcxEaseiySpk6J9mcL0koyfTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771005851; c=relaxed/simple;
	bh=ZkNY9EiZ2dRRQS44gP8N8EFv4YAyNx+kRji/nWvq1kE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NZ/l6Dn0V7+4j7dwfcIk4r8NcmKKAlozDBzTwPd8XoLyDwmF4Ahf1DesdXD+b8czgwPsJ0IgM67KydqycHO56M++n8D6iyds5S/Tlkhu8xC6xdsSrTIVg4N5qcC/ttkb8ZZ6HfO5n7eRnW5AY1TJsrt+I2QfwtOf424N+cJAZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gZp+xvcv; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E1F38C002821;
	Fri, 13 Feb 2026 09:57:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E1F38C002821
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1771005422;
	bh=ZkNY9EiZ2dRRQS44gP8N8EFv4YAyNx+kRji/nWvq1kE=;
	h=From:To:Cc:Subject:Date:From;
	b=gZp+xvcvdeAbb8Xe1w297QdTC0EgTdrAUMBIOIOkVdvf4l/SibUHvFMewOZGK8PCf
	 iH2B5e/RyhsDDSPsvOhBjAJohBO77elOim08BE6axn8fCVUbqo/8e4moe7/vINTwnW
	 09Pp3rZX43/J0IIUwoP+R8GLnz3zrId/FBSrXNfI=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 42645AE93;
	Fri, 13 Feb 2026 12:57:02 -0500 (EST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 6.1 0/2] Mising cache info backports for 6.1
Date: Fri, 13 Feb 2026 09:56:58 -0800
Message-Id: <20260213175700.1964980-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=dkimrelay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-216289-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_PROHIBIT(0.00)[0.0.0.2:email];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.1:email,0.0.0.3:email]
X-Rspamd-Queue-Id: 373A9138CC4
X-Rspamd-Action: no action

Hi Pierre, Greg,

After 22def0b492e683cc5df2a8ef1b94a17be0d50d84 ("arch_topology: Build
cacheinfo from primary CPU") got backported into Linux 6.1.159, I
started seeing on exactly the 3rd system suspend/resume cycle (which
involves CPU hotplug for shutting down secondary cores) the splat below.
Upon closer look, we were missing two commits from upstream in order to
remove the call to of_node_put(this_leaf->fw_token) in
cache_shared_cpu_map_remove().

Thanks!

# pml -d -n0
Disabling console suspend.
Pass 1 out of 1, mode=none, tp_all=1, cycle_tp=, sleep=, wakeup_time=1
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc0 at Thu Jan  1 00:00:47 1970
[   14.944629] PM: suspend entry (deep)
[   14.948256] Filesystems sync: 0.000 seconds
[   14.955442] Freezing user space processes
[   14.960529] Freezing user space processes completed (elapsed 0.001
seconds)
[   14.967507] OOM killer disabled.
[   14.970741] Freezing remaining freezable tasks
[   14.976254] Freezing remaining freezable tasks completed (elapsed
0.001 seconds)
[   15.055371] Disabling non-boot CPUs ...
[   15.059574] OF: ERROR: Bad of_node_put() on
/cpus/cpu@1/cache-controller-1
[   15.066479] CPU: 1 PID: 15 Comm: cpuhp/1 Not tainted
6.1.161-1.7pre-gf269da9a5cdb #2
[   15.074233] Hardware name: BCX974116SFF (DT)
[   15.078507] Call trace:
[   15.080956]  dump_backtrace+0xdc/0x130
[   15.084715]  show_stack+0x1c/0x30
[   15.088035]  dump_stack_lvl+0x60/0x78
[   15.091705]  dump_stack+0x14/0x2c
[   15.095025]  of_node_release+0x144/0x150
[   15.098955]  kobject_put+0xa8/0x210
[   15.102448]  of_node_put+0x1c/0x30
[   15.105855]  cache_shared_cpu_map_remove+0x164/0x230
[   15.110829]  cacheinfo_cpu_pre_down+0x6c/0xb0
[   15.115191]  cpuhp_invoke_callback+0x120/0x680
[   15.119640]  cpuhp_thread_fun+0xd4/0x190
[   15.123567]  smpboot_thread_fn+0x12c/0x220
[   15.127670]  kthread+0x100/0x110
[   15.130902]  ret_from_fork+0x10/0x20
[   15.134504] OF: ERROR: Bad of_node_put() on /cpus/cpu@1
[   15.139776] CPU: 1 PID: 15 Comm: cpuhp/1 Not tainted
6.1.161-1.7pre-gf269da9a5cdb #2
[   15.147530] Hardware name: BCX974116SFF (DT)
[   15.151803] Call trace:
[   15.154251]  dump_backtrace+0xdc/0x130
[   15.158005]  show_stack+0x1c/0x30
[   15.161324]  dump_stack_lvl+0x60/0x78
[   15.164992]  dump_stack+0x14/0x2c
[   15.168312]  of_node_release+0x144/0x150
[   15.172241]  kobject_put+0xa8/0x210
[   15.175734]  kobject_put+0xc0/0x210
[   15.179226]  of_node_put+0x1c/0x30
[   15.182633]  cache_shared_cpu_map_remove+0x164/0x230
[   15.187604]  cacheinfo_cpu_pre_down+0x6c/0xb0
[   15.191967]  cpuhp_invoke_callback+0x120/0x680
[   15.196416]  cpuhp_thread_fun+0xd4/0x190
[   15.200343]  smpboot_thread_fn+0x12c/0x220
[   15.204446]  kthread+0x100/0x110
[   15.207677]  ret_from_fork+0x10/0x20
[   15.211456] psci: CPU1 killed (polled 0 ms)
[   15.217271] OF: ERROR: Bad of_node_put() on
/cpus/cpu@2/cache-controller-2
[   15.224245] CPU: 2 PID: 20 Comm: cpuhp/2 Not tainted
6.1.161-1.7pre-gf269da9a5cdb #2
[   15.232042] Hardware name: BCX974116SFF (DT)
[   15.236342] Call trace:
[   15.238813]  dump_backtrace+0xdc/0x130
[   15.242612]  show_stack+0x1c/0x30
[   15.245969]  dump_stack_lvl+0x60/0x78
[   15.249678]  dump_stack+0x14/0x2c
[   15.253037]  of_node_release+0x144/0x150
[   15.257004]  kobject_put+0xa8/0x210
[   15.260527]  of_node_put+0x1c/0x30
[   15.263968]  cache_shared_cpu_map_remove+0x164/0x230
[   15.268983]  cacheinfo_cpu_pre_down+0x6c/0xb0
[   15.273387]  cpuhp_invoke_callback+0x120/0x680
[   15.277871]  cpuhp_thread_fun+0xd4/0x190
[   15.281831]  smpboot_thread_fn+0x12c/0x220
[   15.285973]  kthread+0x100/0x110
[   15.289235]  ret_from_fork+0x10/0x20
[   15.292926] OF: ERROR: Bad of_node_put() on /cpus/cpu@2
[   15.298301] CPU: 2 PID: 20 Comm: cpuhp/2 Not tainted
6.1.161-1.7pre-gf269da9a5cdb #2
[   15.306097] Hardware name: BCX974116SFF (DT)
[   15.310396] Call trace:
[   15.312865]  dump_backtrace+0xdc/0x130
[   15.316661]  show_stack+0x1c/0x30
[   15.320018]  dump_stack_lvl+0x60/0x78
[   15.323725]  dump_stack+0x14/0x2c
[   15.327082]  of_node_release+0x144/0x150
[   15.331048]  kobject_put+0xa8/0x210
[   15.334572]  kobject_put+0xc0/0x210
[   15.338096]  of_node_put+0x1c/0x30
[   15.341538]  cache_shared_cpu_map_remove+0x164/0x230
[   15.346552]  cacheinfo_cpu_pre_down+0x6c/0xb0
[   15.350955]  cpuhp_invoke_callback+0x120/0x680
[   15.355440]  cpuhp_thread_fun+0xd4/0x190
[   15.359402]  smpboot_thread_fn+0x12c/0x220
[   15.363543]  kthread+0x100/0x110
[   15.366804]  ret_from_fork+0x10/0x20
[   15.370783] psci: CPU2 killed (polled 0 ms)
[   15.375888] OF: ERROR: Bad of_node_put() on
/cpus/cpu@3/cache-controller-3
[   15.382807] CPU: 3 PID: 25 Comm: cpuhp/3 Not tainted
6.1.161-1.7pre-gf269da9a5cdb #2
[   15.390571] Hardware name: BCX974116SFF (DT)
[   15.394851] Call trace:
[   15.397306]  dump_backtrace+0xdc/0x130
[   15.401074]  show_stack+0x1c/0x30
[   15.404403]  dump_stack_lvl+0x60/0x78
[   15.408082]  dump_stack+0x14/0x2c
[   15.411412]  of_node_release+0x144/0x150
[   15.415349]  kobject_put+0xa8/0x210
[   15.418850]  of_node_put+0x1c/0x30
[   15.422264]  cache_shared_cpu_map_remove+0x164/0x230
[   15.427247]  cacheinfo_cpu_pre_down+0x6c/0xb0
[   15.431620]  cpuhp_invoke_callback+0x120/0x680
[   15.436078]  cpuhp_thread_fun+0xd4/0x190
[   15.440013]  smpboot_thread_fn+0x12c/0x220
[   15.444125]  kthread+0x100/0x110
[   15.447364]  ret_from_fork+0x10/0x20
[   15.450987] OF: ERROR: Bad of_node_put() on /cpus/cpu@3
[   15.456263] CPU: 3 PID: 25 Comm: cpuhp/3 Not tainted
6.1.161-1.7pre-gf269da9a5cdb #2
[   15.464027] Hardware name: BCX974116SFF (DT)
[   15.468306] Call trace:
[   15.470759]  dump_backtrace+0xdc/0x130
[   15.474523]  show_stack+0x1c/0x30
[   15.477853]  dump_stack_lvl+0x60/0x78
[   15.481530]  dump_stack+0x14/0x2c
[   15.484860]  of_node_release+0x144/0x150
[   15.488797]  kobject_put+0xa8/0x210
[   15.492297]  kobject_put+0xc0/0x210
[   15.495797]  of_node_put+0x1c/0x30
[   15.499212]  cache_shared_cpu_map_remove+0x164/0x230
[   15.504193]  cacheinfo_cpu_pre_down+0x6c/0xb0
[   15.508567]  cpuhp_invoke_callback+0x120/0x680
[   15.513024]  cpuhp_thread_fun+0xd4/0x190
[   15.516959]  smpboot_thread_fn+0x12c/0x220
[   15.521071]  kthread+0x100/0x110
[   15.524309]  ret_from_fork+0x10/0x20
[   15.528108] psci: CPU3 killed (polled 0 ms)

Pierre Gondois (2):
  cacheinfo: Decrement refcount in cache_setup_of_node()
  cacheinfo: Remove of_node_put() for fw_token

 drivers/base/cacheinfo.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

-- 
2.34.1


