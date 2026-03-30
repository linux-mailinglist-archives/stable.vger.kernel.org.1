Return-Path: <stable+bounces-231226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BrLBk2BymkI9gUAu9opvQ
	(envelope-from <stable+bounces-231226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:57:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACDC35C6DF
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A98283012BCA
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5803B4EB5;
	Mon, 30 Mar 2026 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOpmp/AV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66A43A4517;
	Mon, 30 Mar 2026 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878995; cv=none; b=U7MboNNq2xu1IllORqcebkCLV6ouKduH//zOF9hqziDb9xFSMZYIGPFZd1LqxcSwpgPUkQPAL8fwn4/UjhoBQvn/vwGHI7iTFDWl3Uz3+/Dfc7pZN4A+oG26T/nzLLLPgUnASxgvHUgs47gu0CUu4yoxmxNrImUzMa/l83Eu7W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878995; c=relaxed/simple;
	bh=dOzwqrie4ZhimoQH44OSS4LuSxHdaewpDD3Eov8NQp4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jdoe8fazthIphtbNs88Bgd7YKvGucLjVs2LRH4eAp0IkcpMkJScrmuIXMUHPjydHVupdFwTuJm8/n2T3CHFDRJGsFePf/U8xH/iDgr/1OFeqbXWoD7SyxBSJDRMwfUAn4X0JmE5AvnUcZ/1Zu42c2Ew2TuPPEnmUdHvo39lYG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOpmp/AV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774878993; x=1806414993;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dOzwqrie4ZhimoQH44OSS4LuSxHdaewpDD3Eov8NQp4=;
  b=WOpmp/AVgrEqaTJWkoO4VgKTvbt6O2Kej6uoNLROH8VgD6qCtFRp2kLf
   xHPV8Gq7fnjyXVaI4cUJfDN593fpMJA6zzkSZWOEVKf3C/x3+R+ChvS3R
   OnEoNe159jR2DALKu+6coCJ3fpZVI7f2Y4kD3E0MIYigu37hfLYUS+VcP
   gvTsB/epr1u9/h1nwbM3CsaXsnYFeiOPtmYFAP0e7IAo9a3/JYw9RiG6q
   ZnhJCKKABmWaaksXnZMeBcnXXcAHBW/+T1nvqaGxiR+74jhvKRVQ6F6KM
   6rfKIn4qo5oi3KXZOEDjjuY8d0chyB5QU71MQHc3XF3XfbIQjUUvzMMT6
   Q==;
X-CSE-ConnectionGUID: pgxq2vVvTEKnhqMgrpLyPg==
X-CSE-MsgGUID: vEQ/p53wRnewcsrpJLHtJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75582557"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="75582557"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 06:56:32 -0700
X-CSE-ConnectionGUID: sZ+GrnVfTr6BuVwNQbbAnw==
X-CSE-MsgGUID: O7alXYOkQXmiM/Kr5z6vAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="225951496"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 06:56:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Mar 2026 16:56:24 +0300 (EEST)
To: Bernd Schumacher <bernd@bschu.de>, Lukas Wunner <lukas@wunner.de>
cc: Salvatore Bonaccorso <carnil@debian.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Mario Limonciello <mario.limonciello@amd.com>, 1131025@bugs.debian.org, 
    regressions@lists.linux.dev, stable@vger.kernel.org, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [6.12.y regression] Regression with 58130e7ce6cb ("PCI/ERR:
 Ensure error recoverability at all times"): echo vfio-pci >driver_override
 does not work for DVB Adapter
In-Reply-To: <ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
Message-ID: <97b33e3d-1d95-5012-b599-717b95fa52e2@linux.intel.com>
References: <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>  <acfZrlP0Ua_5D3U4@eldamar.lan> <acfhf-odtr0yw_py@wunner.de>  <74bcd84500e5efcca035624f325e400dd8a21f44.camel@bschu.de>  <acgohjvBpVcR7HcK@wunner.de> 
 <5f9386146f426e2847550681cb7188471205607f.camel@bschu.de>  <aclRwznwq6KpA2qA@wunner.de> <ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-467875100-1774878984=:968"
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231226-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 6ACDC35C6DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-467875100-1774878984=:968
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 30 Mar 2026, Bernd Schumacher wrote:

> Am Sonntag, dem 29.03.2026 um 18:22 +0200 schrieb Lukas Wunner:
> > Could you repeat this and add log_buf_len=3D16M to the kernel command
> > line
> > so that the dmesg output isn't truncated?
>=20
> I have now added=C2=A0to /etc/default/grub:
> GRUB_CMDLINE_LINUX=3D"\"dyndbg=3Dfile log_buf_len=3D16M drivers/pci/* +p\=
""
> attached is the dmesg result for 6.12.73

Hi,

This doesn't look like a resource assignment issue to me.

HOWEVER,

despite the assignment being successful, what is worth a note is that BAR=
=20
0 changes during resource fitting:

pci 0000:07:00.0: BAR 0 [mem 0xfffffffffc500000-0xfffffffffc50ffff 64bit]: =
can't claim; no compatible bridge window
pci 0000:07:00.0: BAR 0 [mem 0xfc500000-0xfc50ffff 64bit]: assigned

That is 0xffffffff -> 0x0 for the high order bits happens to match with=20
the change Lukas noted (I've not digged deeply into the logs beyond=20
checking the resource fitting/assignment results from the latest log).

Perhaps something on the save/restore side still holds the old value=20
despite the resource & BAR were changed during resource fitting?

--=20
 i.

--8323328-467875100-1774878984=:968--

