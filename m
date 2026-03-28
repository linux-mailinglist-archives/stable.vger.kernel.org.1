Return-Path: <stable+bounces-230787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBGZB8PZx2mAdgUAu9opvQ
	(envelope-from <stable+bounces-230787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 14:38:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B62A634E897
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 14:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99196302529F
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 13:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CA2361DC0;
	Sat, 28 Mar 2026 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nqikSHl2"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499E13C8E8;
	Sat, 28 Mar 2026 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774705083; cv=none; b=t4cq6tykRLLOz8JbobQ1C9U1W2rtrz3p3FMJYrisdVMp9PzPoKLwZYLnsWoPOh4wmz6hImg4WjY16QUcmPxj/Z41vu2ofDjSoCqDtIBIQtSveyvUE05n+TWZtiBazK5apugrNxu8yWOqefppMLa1+SgOzUACHzLj+NBNTixbk5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774705083; c=relaxed/simple;
	bh=y7EktVPKrbpXnzb03QrFWrQ09ZfBeJjI/6fJuqcRu20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wqlp5NKD/wcsWIfiBhalaXK0Ks2HUm7PCsQkgUeauC0NUP5fbWyamOeQ/JORp6gfcwMolyi5wA/crDv9+DF6U/MqzehCZJIfd47QoifDqQAK21fhOlktRD62PZV4Irr0HeNZsblh82zCvTGTO+yn7Zdr3EgWwFUm2t24wYqx/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nqikSHl2; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cTnJoJp4JSSYOR+xDGISIrqz9KLc+P5P1xJH7djkdEk=; b=nqikSHl26avalNQQc0AF6gG/+v
	PqmBklBAKVmAvW69+DdHPNoDoV3Zm63NxBIayqWuOwb/eQn46wZ4PmRi2xJ3m9oDc9FLUl4b6K3qn
	czRp9nnXEl3XiiobXBHRlPePGUxUGi9XwwSqaQZLv1i56ITL6TBC8hzAS6MuHW5X9zOiZTDlmKOEi
	pSKGjFKmZJEDUZ/pTV1S+sDRQRBXpYxjYivCsJ6sB1WHiQeq+iNNhWs6YiNPcwKUBZBbTi0aKruHl
	kKUZ0GCTgeW9kYAtzXxNsWW4Y+iaeLMvrdC7gxooM2ES92eFEPkGx0camBl6+KhUImDQKPHOJwCWT
	5md7/8XQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1w6TrL-00BRga-HE; Sat, 28 Mar 2026 13:37:51 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 69D67BE2EE7; Sat, 28 Mar 2026 14:37:50 +0100 (CET)
Date: Sat, 28 Mar 2026 14:37:50 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: bernd@bschu.de, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: 1131025@bugs.debian.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [6.12.y regression] Regression with 58130e7ce6cb ("PCI/ERR: Ensure
 error recoverability at all times"): echo vfio-pci >driver_override does not
 work for DVB Adapter
Message-ID: <acfZrlP0Ua_5D3U4@eldamar.lan>
References: <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
Messsage-ID: <177470500712.1307944.17082968691510345174@eldamar.lan>
X-Debian-User: carnil
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	TAGGED_FROM(0.00)[bounces-230787-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B62A634E897
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Control: forwarded -1 https://lore.kernel.org/regressions/177470500712.1307944.17082968691510345174@eldamar.lan

Hi,

Bernd Schumacher reported in Debian (report and report from bisection
in https://bugs.debian.org/1131025) a 6.12.y specific regression of
58130e7ce6cb ("PCI/ERR: Ensure error recoverability at all times"):

On Tue, Mar 17, 2026 at 08:18:17AM +0100, Bernd Schumacher wrote:
>    * What led up to the situation?
> I have a kvm with linux-image-6.1.0-43-amd64 running vdr and femon.
> On the host I do echovfio-pci >/sys/bus/pci/devices/0000:$PCI/driver_override.
> Then I give the DVB Adapter to the kvm.
> 
> It works, if I boot linux-image-6.12.63+deb13-amd64 on the host.
> If it works dmesg on the kvm says:
> 05:00.0 Multimedia controller: Digital Devices GmbH Octopus DVB Adapter
> dmesg:
> [    2.443770] dvbdev: DVB: registering new adapter (DDBridge)
> [    2.443772] dvbdev: DVB: registering new adapter (DDBridge)
> ...
> [    2.694180] ddbridge 0000:05:00.0: attach tuner input 0 adr 60
> [    2.694183] ddbridge 0000:05:00.0: DVB: registering adapter 0 frontend 0 (STV090x Multistandard)...
> ...
> [    2.738542] ddbridge 0000:05:00.0: attach tuner input 1 adr 63
> [    2.738545] ddbridge 0000:05:00.0: DVB: registering adapter 1 frontend 0 (STV090x Multistandard)...
> 
> 
> It does not work, if I boot linux-image-6.12.73+deb13-amd64 on thehost.
> If it does not work dmesg on th kvm says:
> [    2.413879] ddbridge 0000:05:00.0: detected Digital Devices Cine S2 V6 DVB adapter
> [    2.413901] ddbridge 0000:05:00.0: cannot read registers
> [    2.414569] ddbridge 0000:05:00.0: fail
> 
> If I run femon it says:
> femon: opening frontend failed: No such file or directory

https://bugs.debian.org/1131025#29 contains the bisect log:

| git bisect log says:
| 
| git bisect start
| # Status: warte auf guten und schlechten Commit
| # good: [567bd8cbc2fe6b28b78864cbbbc41b0d405eb83c] Linux 6.12.63
| git bisect good 567bd8cbc2fe6b28b78864cbbbc41b0d405eb83c
| # Status: warte auf schlechten Commit, 1 guter Commit bekannt
| # bad: [5fb0303f6cb6a89bcfb19bd7a68cb793c86e78b2] Linux 6.12.73
| git bisect bad 5fb0303f6cb6a89bcfb19bd7a68cb793c86e78b2
| # good: [b1dd6860167667008c3b6f27628d071dc3daaf04] smb/client: fix
| NT_STATUS_UNABLE_TO_FREE_VM value
| git bisect good b1dd6860167667008c3b6f27628d071dc3daaf04
| # good: [1baa43ebca626aa607a03b1c0023ebac5374e62d] octeontx2-af: Fix
| error handling
| git bisect good 1baa43ebca626aa607a03b1c0023ebac5374e62d
| # good: [3845bd336a406cb7c609b515e6ee4c8818053f69] net/sched: act_ife:
| convert comma to semicolon
| git bisect good 3845bd336a406cb7c609b515e6ee4c8818053f69
| # bad: [2901d799a26d949ccf648a6c176a0091a7f1c0ed] ALSA: hda/realtek:
| Fix headset mic for TongFang X6AR55xU
| git bisect bad 2901d799a26d949ccf648a6c176a0091a7f1c0ed
| # bad: [b9b97e6aeb534315f9646b2090d1a5024c6a4e82] procfs: avoid
| fetching build ID while holding VMA lock
| git bisect bad b9b97e6aeb534315f9646b2090d1a5024c6a4e82
| # good: [b8ea101959ab1a46c92be46c238283b0fe60252e] pmdomain: imx:
| gpcv2: Fix the imx8mm gpu hang due to wrong adb400 reset
| git bisect good b8ea101959ab1a46c92be46c238283b0fe60252e
| # good: [dfc3ab6bd64860f8022d69903be299d09be86e11] mm, shmem: prevent
| infinite loop on truncate race
| git bisect good dfc3ab6bd64860f8022d69903be299d09be86e11
| # bad: [9bcc47343ee0ef346aa7b2b460c8ff56bd882fe7] ublk: fix deadlock
| when reading partition table
| git bisect bad 9bcc47343ee0ef346aa7b2b460c8ff56bd882fe7
| # good: [ff48c9312d042bfbe826ca675e98acc6c623211c] KVM: Don't clobber
| irqfd routing type when deassigning irqfd
| git bisect good ff48c9312d042bfbe826ca675e98acc6c623211c
| # bad: [d288ba832d92d16f7db0f6996ffbde2e79190ffe] tools/power
| turbostat: fix GCC9 build regression
| git bisect bad d288ba832d92d16f7db0f6996ffbde2e79190ffe
| # bad: [58130e7ce6cb6e1f73221e412fef6c85ee561425] PCI/ERR: Ensure error
| recoverability at all times
| git bisect bad 58130e7ce6cb6e1f73221e412fef6c85ee561425
| # first bad commit: [58130e7ce6cb6e1f73221e412fef6c85ee561425] PCI/ERR:
| Ensure error recoverability at all times

And https://bugs.debian.org/1131025#43 confirms again the single
revert fixing the issue.

#regzbot introduced: 58130e7ce6cb6e1f73221e412fef6c85ee561425
#regzbot link: https://bugs.debian.org/1131025

Anything else we can provide to identify the issue present in 6.12.y
kernels?

Regards,
Salvatore

