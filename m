Return-Path: <stable+bounces-180452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC02FB81FD6
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 23:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A0D3B1B50
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 21:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C9921C194;
	Wed, 17 Sep 2025 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxvJL4+C"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D530DD16
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145074; cv=none; b=kPxm+6Q2N3ONqsCqjmJgnMC9GSPOquF/BVJlB0oSaDyE9Zpj574DURmWQa39ckVN8xcx83neRT6yYO4eaC6t2RJbtR6PVBrYGNrOkV7fZwgWoM129SjyOHTkehQaqFxU4yuMrtf6hI0vjMstNMBpK3w52CjC9ktvo6NCIIy+1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145074; c=relaxed/simple;
	bh=/JhtPfJaQiCKSIX/TuTfrAD7OYsN3RQ0tOkgWbfXy8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G4WAvKBqt8UYzMNF885Uas3kTP+f8mKspzOc0r2B1rlTPWAbfkK+BLsfQQKKkZJ+q5HHa/6PlAhjC3WhmVS1FnqT5ZC6c77ejaF+/SezyE46Pg7mw4vDLOW1EUw3uoRAO1vW+6+E/LOJul06umm7EO4rpFlW6thyHUlC4hLYSHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxvJL4+C; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758145073; x=1789681073;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/JhtPfJaQiCKSIX/TuTfrAD7OYsN3RQ0tOkgWbfXy8w=;
  b=BxvJL4+CJJOfk4gIJL3rLzYA7Vqdg5mDQBJR0vWKo5Ndef2C29uUOzJ0
   0DxZYacP7CKACFTCE+NuNWYbUDNuTyr7OxjVg7gGbIHCbX0q1mRBiFH6P
   5FUbVhog4RJrVrA4R/B4ja78M5okV+qjX4ZrZusnqL/++tppjfiJo3Ay6
   s6EYPwUZ6n27Z76+O1AZhBuFP/HLk0wIN/5TEBcmPBuintWvWfgU9zXC1
   l0QKiaERIg4R5JtVif5C4JwaHlEfx042kyK7vKZuZg/Oo418y1bsWZx8a
   pvKqRGPw9EVuM2N03HsXxVahGFAQct0jlfcu5f3loZfkQEFiKZkFR8kF9
   Q==;
X-CSE-ConnectionGUID: Hap5oC5YRGKrEW6jCEVtJQ==
X-CSE-MsgGUID: 2ZqWCf32TYWNOa5HE0VXAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60522745"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60522745"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 14:37:52 -0700
X-CSE-ConnectionGUID: I48fL1SaSAelzkyZZOGSrA==
X-CSE-MsgGUID: 70k54UhfRkOchs8AuyH1Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="179643051"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 14:37:52 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 0/3] drm/xe: Fix some rebar issues
Date: Wed, 17 Sep 2025 14:37:29 -0700
Message-ID: <20250917-xe-pci-rebar-2-v1-0-005daa7c19be@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250917-xe-pci-rebar-2-c0fe2f04c879
X-Mailer: b4 0.15-dev-b03c7
Content-Transfer-Encoding: 8bit

Our implementation for BAR2 (lmembar) resize works at the xe_vram layer
and only releases that BAR before resizing. That is not always
sufficient. If the parent bridge needs to move, the BAR0 also needs to
be released, otherwise the resize fails. This is the case of not having
enough space allocated from the beginning.

Also, there's a BAR0 in the upstream port of the pcie switch in BMG
preventing the resize to propagate to the bridge as previously discussed
at https://lore.kernel.org/intel-xe/20250721173057.867829-1-uwu@icenowy.me/
and https://lore.kernel.org/intel-xe/wqukxnxni2dbpdhri3cbvlrzsefgdanesgskzmxi5sauvsirsl@xor663jw2cdw
I'm bringing that commit from Ilpo here so this can be tested with the
xe changes and go to stable (first 2 patches).

The third patch is just code move as all the logic is in a different
layer now. That could wait longer though as there are other refactors
coming through the PCI tree and that would conflict (see second link
above).

With this I could resize the lmembar on some problematic hosts and after
doing an SBR, with one caveat: the audio device also prevents the BAR
from moving and it needs to be manually removed before resizing. With
the PCI refactors and BAR fitting logic that Ilpo is working on, it's
expected that it won't be needed for a long time.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
Ilpo Järvinen (1):
      PCI: Release BAR0 of an integrated bridge to allow GPU BAR resize

Lucas De Marchi (2):
      drm/xe: Move rebar to be done earlier
      drm/xe: Move rebar to its own file

 drivers/gpu/drm/xe/Makefile       |   1 +
 drivers/gpu/drm/xe/xe_pci.c       |   3 +
 drivers/gpu/drm/xe/xe_pci_rebar.c | 125 ++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_pci_rebar.h |  13 ++++
 drivers/gpu/drm/xe/xe_vram.c      | 103 -------------------------------
 drivers/pci/quirks.c              |  20 ++++++
 6 files changed, 162 insertions(+), 103 deletions(-)

base-commit: 95bc43e85f952ef4ebfff1406883e1e07a7daeda
change-id: 20250917-xe-pci-rebar-2-c0fe2f04c879

Lucas De Marchi


