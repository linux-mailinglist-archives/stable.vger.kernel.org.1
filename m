Return-Path: <stable+bounces-179295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CF1B53905
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 18:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8B1485726
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 16:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F01636209A;
	Thu, 11 Sep 2025 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KB5ySTpW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7FA35AAB7;
	Thu, 11 Sep 2025 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607693; cv=none; b=LssJZsgIyAe0IDSHVwvC5zHawyYtP3EtgskZ9xZzLphykFBai+SaAIY1lFB5ETkt27bFqmRAqw0TrALzFlnv1XUTVcZ4BqYSJJiYE5cCSD+ItXojWCeqERy876Z3bLV1kGXJQlzQRwOIfJpwty/Md4Yvc5GsQZ06jn0KxEdd5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607693; c=relaxed/simple;
	bh=5NlXwf34cSTaXuh9eG5LWAv3foKGH4k9yBS1eDxzSQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2tOD1FYYn91XhSPg1fUr52m45H3/2ZBWjXhjNefIIr9umlunRkz9TVvwsGTHurgCZBiaaz3M0rUh94Qr6lnSTNOVH7mc2GJRi/lwQSTgB6DCaWykCexdM6hpRRBlIB5FMZqqpmhr2iFH5idRfm2r8WWC8R8yNrZgzCvryHel8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KB5ySTpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B56C4CEF5;
	Thu, 11 Sep 2025 16:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757607692;
	bh=5NlXwf34cSTaXuh9eG5LWAv3foKGH4k9yBS1eDxzSQE=;
	h=From:To:Cc:Subject:Date:From;
	b=KB5ySTpWjPF21vOJA/Uhvta7ttj2LPANINt/513Pq4xuESZYOLhdgrEKNyvRnbdJG
	 iYVSpu0Ffn13xJeiYobgKzeHfqrq9NLg2k1S8RPBAfF4p+d6Ks1RUV3kKrjAtk9Hfu
	 gwoTI99gudHPV4S1En9TpZ/Hg6uWEnENaSmKIUMg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.47
Date: Thu, 11 Sep 2025 18:21:18 +0200
Message-ID: <2025091119-credible-mule-c80c@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.47 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu |    1 
 Documentation/admin-guide/hw-vuln/index.rst        |    1 
 Documentation/admin-guide/hw-vuln/vmscape.rst      |  110 ++++++++
 Documentation/admin-guide/kernel-parameters.txt    |   11 
 Makefile                                           |    2 
 arch/x86/Kconfig                                   |    9 
 arch/x86/include/asm/cpufeatures.h                 |    2 
 arch/x86/include/asm/entry-common.h                |    7 
 arch/x86/include/asm/nospec-branch.h               |    2 
 arch/x86/kernel/cpu/bugs.c                         |  257 ++++++++++++++-------
 arch/x86/kernel/cpu/common.c                       |   84 ++++--
 arch/x86/kvm/x86.c                                 |    9 
 drivers/base/cpu.c                                 |    3 
 include/linux/cpu.h                                |    1 
 14 files changed, 394 insertions(+), 105 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.12.47

Pawan Gupta (7):
      Documentation/hw-vuln: Add VMSCAPE documentation
      x86/vmscape: Enumerate VMSCAPE bug
      x86/vmscape: Add conditional IBPB mitigation
      x86/vmscape: Enable the mitigation
      x86/bugs: Move cpu_bugs_smt_update() down
      x86/vmscape: Warn when STIBP is disabled with SMT
      x86/vmscape: Add old Intel CPUs to affected list


