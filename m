Return-Path: <stable+bounces-224498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFkQB9wcsGkngAIAu9opvQ
	(envelope-from <stable+bounces-224498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 14:30:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C7425051E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 14:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C26C531511D1
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1221335A3B2;
	Tue, 10 Mar 2026 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSnIFJhu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF7E38B134
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143867; cv=none; b=uvvuCjtkWu9o8xULWHTkzkuI6HssSp3RBvrBYOM8/mdV2EhOrvwFhB4PeEMqV81LruqEnttqUyLq0DaU53V2Me6eXaksVxDw743Mh6pz2FoYrj+mKuU1D2zHrqWZ0xfTD4s39LEjKuX1QCa5lG+s0NOOt3pjPTFI+IogW/ilBIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143867; c=relaxed/simple;
	bh=aSMZDpvUgLluBKOIRlanJKEP/gkSJLftLRgZUIk89GQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GcjfwPqxK/NkvsB12G//7k85oayWSbnsZy6ya4RaDOKaG4FC+Rg+EtkehhUkSejFHYbsTqMC779RzIg5avlI54pJ+Z3AwMPqTOdP13Q99RsX733S8e7Ck1DHbG/X47kS+zngdM34Np62iAvnHncoch8l/LTujtkYJ1B41OB1r+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSnIFJhu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773143859; x=1804679859;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aSMZDpvUgLluBKOIRlanJKEP/gkSJLftLRgZUIk89GQ=;
  b=GSnIFJhu1tcVYxd7T77uuvKORn0wR5rIOeOXURXRhM0MNbKK2bAtU32c
   mozWqOwdp56IEpvwDfOTK5vJYcjUP8XEnBk6fUlg6hoF/4hLDblquF6DR
   T23UMGbLJgtyXgrgSREsMcLs2VMVFCeNcG7pVxuz3X9Ag5XAQ8TJZ5S7e
   bcSHCEPbnQ6qV6pez8RC/Bsa13Nf3siui0drl0pghQWfJGVq9+Cfgyir+
   9VCYtQoTvcbIgoUiD4LQNNNeAxN1c+8wLf2fEGEN+fEIwl9AGNCOCRIq2
   fB/7UPsFqcWwUccpzPxxl++G+V42WMuMuFmoFBitUl33KBZ+bKqQyTJnj
   g==;
X-CSE-ConnectionGUID: L3NYSHa4TPuJbfy3GxV0kQ==
X-CSE-MsgGUID: F7LVELYhRvK7t5aOiDpX3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="84897874"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="84897874"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 04:57:38 -0700
X-CSE-ConnectionGUID: 9WIlatWxQcOiYBNiHHrqiw==
X-CSE-MsgGUID: BbqkrnYaTOGdoo4yt+6izQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="224773038"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
  by fmviesa005.fm.intel.com with ESMTP; 10 Mar 2026 04:57:33 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: contact@emersion.fr,
	alex.hung@amd.com,
	harry.wentland@amd.com,
	daniels@collabora.com,
	mwen@igalia.com,
	sebastian.wick@redhat.com,
	uma.shankar@intel.com,
	ville.syrjala@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	jani.nikula@intel.com,
	louis.chauvet@bootlin.com,
	stable@vger.kernel.org,
	chaitanya.kumar.borah@intel.com
Subject: [PATCH v2 0/2] drm/colorop: Keep colorop state consistent across atomic commits
Date: Tue, 10 Mar 2026 17:02:36 +0530
Message-Id: <20260310113238.3495981-1-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 84C7425051E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224498-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chaitanya.kumar.borah@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,bootlin.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,emersion.fr:email,01.org:url]
X-Rspamd-Action: no action

This series aims to keep colorop state consistent across atomic
transactions by ensuring it accurately reflects committed hardware
state and remains part of the atomic update whenever its associated
plane is involved.

It contains two changes:
- Preserves the bypass value in duplicated colorop state.

_drm_atomic_helper_colorop_duplicate_state() unconditionally reset
bypass to true, which means the duplicated state no longer reflects the
committed hardware state. Since bypass directly controls whether the
colorop is active in hardware, this can lead to an unintended disable
during subsequent commits.

This could potentially be a problem also for colorops where bypass value
is immutably false.

Conceptually, I consider 'bypass' to behave similar to 'visible' in plane 
state - it represents current HW state and should therefore be preserved
across duplication.

- Add affected colorops with affected plane

Colorops are unique in the DRM model. While they are DRM objects with their
own states, they are logically attached to a plane and exposed through
a plane property. In some sense, they share the same hierarchy as CRTC and
planes while following a different 'ownership' model.

Given that enabling a CRTC pulls in all its affected planes into the atomic
state, it follows that when a plane is added, its associated colorops are
also included. Otherwise, during modesets or internal commits, colorop state
may be missing from the transaction, resulting in inconsistent or incomplete
state updates.

That said, I do have a concern about potentially inflating the atomic
state by automatically pulling in colorops from the core. It is not
entirely clear to me whether inclusion of affected colorops should be
handled in core, or left to individual drivers.

My understanding of the atomic framework is still evolving, so
I would appreciate feedback from those more familiar with the intended
design direction.

==
Chaitanya

P.S/Background/TL;DR:

I discovered inconsistency with the colorop state while analysing CRC mismatches
in kms_color_pipeline test cases[1]. Visual inspection reveals that while CRC is
being collected degamma block has been reset. This was traced back to the internal
commit that the driver does to disable PSR2 and selective fetch for CRC collection.

crtc_crc_open
    -> intel_crtc_set_crc_source
        -> intel_crtc_crc_setup_workarounds
            -> drm_atomic_commit

During this flow colorop states are never added to the atomic state which in turn
makes intel_plane_color_copy_uapi_to_hw_state() disable the colorops.

If we add the colorops, to the atomic state, the problem still persisted because
while duplicating the colorop state, 'bypass' was getting reset to true.

The two changes made in this series fixes the issue.

[1] https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_18001/shard-mtlp-6/igt@kms_color_pipeline@plane-lut1d.html

v2:
  - Add affected colorops only when a pipeline is enabled

Cc: Simon Ser <contact@emersion.fr>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Daniel Stone <daniels@collabora.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Sebastian Wick <sebastian.wick@redhat.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Uma Shankar <uma.shankar@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: <stable@vger.kernel.org> #v6.19+

Chaitanya Kumar Borah (2):
  drm/colorop: Preserve bypass value in duplicate_state()
  drm/atomic: Add affected colorops with affected planes

 drivers/gpu/drm/drm_atomic.c  | 7 +++++++
 drivers/gpu/drm/drm_colorop.c | 2 --
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.25.1


