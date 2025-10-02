Return-Path: <stable+bounces-182998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60846BB21E7
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 02:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D634420CBE
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 00:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E8733987;
	Thu,  2 Oct 2025 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YlXnyBpT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D3D134BD;
	Thu,  2 Oct 2025 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759364233; cv=none; b=FV/jETd7CwWBijIZdiWko5MMCGNDIKJqV4CGOPnLD7Sad23oSqzF8rAhHjSgHU9seUR//2eqy1XH1AUJxbpWqoKAPMei9SL68y47pj5KTgqL2YDpY+fVwueQb2cUsiZwyCXy4Hs9EMyOO11SyJMhSP+6rktEi6yzgULXU942laE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759364233; c=relaxed/simple;
	bh=qDzFaanVpi5FMCY6mdFJbc771cYhK6nwd1MnoMmHsV8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mQUyELGil3C6/ZWyc0OFTKGV59/6KDJsrdMGmzONu3yvPTP+A1kl4BFZ8g/azblU2GT2kl2iYg+yV4EyOFVe2xXl2/kQPJdYpmX7uAgDV023qOkBE7PJuKiHzBVbiQhlY4KpcN4U4GiZ9685CxbL+pdkXRzoVvBMIRCh1j/Xmoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YlXnyBpT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759364232; x=1790900232;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=qDzFaanVpi5FMCY6mdFJbc771cYhK6nwd1MnoMmHsV8=;
  b=YlXnyBpTK7vgKC9jXnzLVdqqHVDEZU2FUm+NwlXVXggm95FWcskVxEeJ
   HkGnwGkDHqALjUZznVgleOJGO1FKDNQjt5GlZ9d9ylqiy52hXXcZM08CC
   0MsNUlzWYhQI4CdcSWkTJJxvjqVC48aEo5qhsH0sAkoR20KET0kn/goLk
   LmXQ555UrAOXfDCl+pk6ZiXSyhxzv2or98zPIlg6SCZ+8Yep3rzYzUy7y
   d27/r1SIpTZdWrUuyawFuOeIJX/uTRZYaNTpE5nsh7zL2bU6J74CdyMA1
   l/pl+uNVhj4vhTT80M5j2i/lZcmYv4uZ3RrQwsKc+1ZxryZw7XlI85mYk
   g==;
X-CSE-ConnectionGUID: KGR/sO+fRyqvZm7kL80aVg==
X-CSE-MsgGUID: +Qbe4B3aRhesuqD1Hp6DrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61561585"
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="61561585"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 17:17:10 -0700
X-CSE-ConnectionGUID: qWs7ETUsRMaf/ns0UnvGaw==
X-CSE-MsgGUID: YyVV10piTe2UZTY0KPBv9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="184105711"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 17:17:09 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 0/8] Intel Wired LAN Driver Updates 2025-10-01 (idpf,
 ixgbe, ixgbevf)
Date: Wed, 01 Oct 2025 17:14:10 -0700
Message-Id: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANTD3WgC/x2M0QpAQBBFf0XzbGp3CvEr8iBmGbS0K5T8u+Hxn
 O65N0QOwhGq5IbAh0RZvYJNE+jG1g+M0isDGcqsMRanGeVc0POOn0NrUG1JXU9tTrlzBWi7BXZ
 y/b816Baa53kBJuq1TmwAAAA=
X-Change-ID: 20251001-jk-iwl-net-2025-10-01-92cd2a626ff7
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Phani Burra <phani.r.burra@intel.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: Anton Nadezhdin <anton.nadezhdin@intel.com>, 
 Konstantin Ilichev <konstantin.ilichev@intel.com>, 
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Samuel Salin <Samuel.salin@intel.com>, 
 Chittim Madhu <madhu.chittim@intel.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, 
 Andrzej Wilczynski <andrzejx.wilczynski@intel.com>, stable@vger.kernel.org, 
 Rafal Romanowski <rafal.romanowski@intel.com>, 
 Koichiro Den <den@valinux.co.jp>, Rinitha S <sx.rinitha@intel.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=3087;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=qDzFaanVpi5FMCY6mdFJbc771cYhK6nwd1MnoMmHsV8=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoy7R+rN7f8ecspX1Qx53i0vu2zxXVu1WfzOQSY1Syy7n
 0xwf7Swo5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIlM38/wm21/5ZlfmTcEIk1n
 nKnJb/jDLsv8PuHXhXWZVx7dfv9c35yRYWbWpO2eXxxy9GR3WkqIXOGadWCG7IG5jctN9PK9t08
 XZQAA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

For idpf:
Milena fixes a memory leak in the idpf reset logic when the driver resets
with an outstanding Tx timestamp.

Emil fixes a race condition in idpf_vport_stop() by using
test_and_clear_bit() to ensure we execute idpf_vport_stop() once.

For ixgbe and ixgbevf:
Jedrzej fixes an issue with reporting link speed on E610 VFs.

Jedrzej also fixes the VF mailbox API incompatibilities caused by the
confusion with API v1.4, v1.5, and v1.6. The v1.4 API introduced IPSEC
offload, but this was only supported on Linux hosts. The v1.5 API
introduced a new mailbox API which is necessary to resolve issues on ESX
hosts. The v1.6 API introduced a new link management API for E610. Jedrzej
introduces a new v1.7 API with a feature negotiation which enables properly
checking if features such as IPSEC or the ESX mailbox APIs are supported.
This resolves issues with compatibility on different hosts, and aligns the
API across hosts instead of having Linux require custom mailbox API
versions for IPSEC offload.

Koichiro fixes a KASAN use-after-free bug in ixgbe_remove().

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Emil Tantilov (2):
      idpf: convert vport state to bitmap
      idpf: fix possible race in idpf_vport_stop()

Jedrzej Jagielski (4):
      ixgbevf: fix getting link speed data for E610 devices
      ixgbe: handle IXGBE_VF_GET_PF_LINK_STATE mailbox operation
      ixgbevf: fix mailbox API compatibility by negotiating supported features
      ixgbe: handle IXGBE_VF_FEATURES_NEGOTIATE mbox cmd

Koichiro Den (1):
      ixgbe: fix too early devlink_free() in ixgbe_remove()

Milena Olech (1):
      idpf: cleanup remaining SKBs in PTP flows

 drivers/net/ethernet/intel/idpf/idpf.h             |  12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h       |  15 ++
 drivers/net/ethernet/intel/ixgbevf/defines.h       |   1 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h       |   7 +
 drivers/net/ethernet/intel/ixgbevf/mbx.h           |   8 +
 drivers/net/ethernet/intel/ixgbevf/vf.h            |   1 +
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |  10 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |  23 ++-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c         |   3 +
 .../net/ethernet/intel/idpf/idpf_singleq_txrx.c    |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |   4 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl_ptp.c    |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |  79 +++++++++
 drivers/net/ethernet/intel/ixgbevf/ipsec.c         |  10 ++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |  34 +++-
 drivers/net/ethernet/intel/ixgbevf/vf.c            | 182 +++++++++++++++++----
 18 files changed, 335 insertions(+), 62 deletions(-)
---
base-commit: daa26ea63c6f848159821cd9b3cbe47cddbb0a1c
change-id: 20251001-jk-iwl-net-2025-10-01-92cd2a626ff7

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


