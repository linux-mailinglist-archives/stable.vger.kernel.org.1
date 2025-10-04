Return-Path: <stable+bounces-183348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A30A2BB8777
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 03:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 113AE4E5571
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 01:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C207083C;
	Sat,  4 Oct 2025 01:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4dK1s6h"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B4339A8;
	Sat,  4 Oct 2025 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759540305; cv=none; b=jPcpYSs3l8mIMpWUajZupmYKFB03f9eIcm+OrG3nSrj+12uYqi5PZHXc3Mc5QuhrDDl4QvcvN7XKFdB0cxXhGwNjmT8AE5G/iAZCIgkAIB0XkIZeV+U6sklIjRosdp8cPpsfelisDdrtM1Mw8MpkSH23FIAT/fsJ1c7mPseGdak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759540305; c=relaxed/simple;
	bh=bBclfd7/cZYUQQnneA4t6jaFujfjXiOWpFnfZwVOuI4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NUzfr4mLgKEoC3myfyXLjqOt/xANjXk+e6pkPdDWNp7FrVm9b3EzuFwzKGero3VT44BWta8iarN9uZjKc6B9/Z1wpbMukjXHfRrSdRb8LUA+JZMxVFC00pbb9a60yW5j2JP7oYuToDVOAPoI/fzpjiAjWUdq6hvAbIUnMifL87s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4dK1s6h; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759540304; x=1791076304;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=bBclfd7/cZYUQQnneA4t6jaFujfjXiOWpFnfZwVOuI4=;
  b=d4dK1s6hzCSq+9/tZmV1BQ1Fi7fcrKe2TNjEcZmsjWn2SrlFSNyOGVbt
   aMXShFWByTa8TKf7ls0YoJfGT/LCTA1ah1ybP92u8LNHO/I7IaV44LHZO
   H49esQb7H4PzfPSCOnNQFe8GIRF5Bz5WA+M0dMWAqCsn5Y39HhV8LpFTB
   zWRVxggTVyQsjZfzTCDJYWzWVHkYzoLr6dvP2TNVG73nGfBnM1Cs12jD/
   8Fp3JsF3dML4haWaSmumb5suC+cHFVfZZL9tdk15QWEekJDRGRcSTOhqI
   9UD4U927+wS+uIniBYo0ECWl8y8Vp9UgKasGNRY9gvR9XGUCLI5m5sf+H
   w==;
X-CSE-ConnectionGUID: ZtgN6B++RpOFPBhbDo5lqw==
X-CSE-MsgGUID: QueNR9YuT16EbV9r3+cQTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65650002"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65650002"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 18:11:43 -0700
X-CSE-ConnectionGUID: XCXsbnPRRWKwQ8fYhM9Nng==
X-CSE-MsgGUID: ZJ0rSX+MQB+JKO+Pt0hOmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; 
   d="scan'208";a="178543200"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 18:11:43 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net v2 0/6] Intel Wired LAN Driver Updates 2025-10-01
 (idpf, ixgbe, ixgbevf)
Date: Fri, 03 Oct 2025 18:09:43 -0700
Message-Id: <20251003-jk-iwl-net-2025-10-01-v2-0-e59b4141c1b5@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANlz4GgC/4WNTQ7CIBCFr9LM2jEDURRX3sN0QdrBjlZqgFRN0
 7uLXMDl+97fAomjcIJTs0DkWZJMoQi9aaAbXLgySl80aNJ7RaTwdkd5jRg444+hIizU6q7Xzmj
 j/QFK9xnZy7vuXqBkoS1wkJSn+Klfs6rWn9lZIeHOemctH40hOkvIPG676QHtuq5fQFd7678AA
 AA=
X-Change-ID: 20251001-jk-iwl-net-2025-10-01-92cd2a626ff7
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Phani Burra <phani.r.burra@intel.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: Anton Nadezhdin <anton.nadezhdin@intel.com>, 
 Konstantin Ilichev <konstantin.ilichev@intel.com>, 
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Samuel Salin <Samuel.salin@intel.com>, 
 Andrzej Wilczynski <andrzejx.wilczynski@intel.com>, stable@vger.kernel.org, 
 Rafal Romanowski <rafal.romanowski@intel.com>, 
 Koichiro Den <den@valinux.co.jp>, Rinitha S <sx.rinitha@intel.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=bBclfd7/cZYUQQnneA4t6jaFujfjXiOWpFnfZwVOuI4=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowHJZ49GfvPx0jUa8da911alq95NGmmbvRj4zdOiZvuv
 NFYfyCpo5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgInkzGT4n9jLwdTzR6rc5+Hx
 k5M2xLtO/C60dtaG9ZNsLmowfJK9dJ6R4Xvc2pXTf+m2Gk88s8pKgmX5kt0zPGa8qujvf62yMtt
 UhRkA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

For idpf:
Milena fixes a memory leak in the idpf reset logic when the driver resets
with an outstanding Tx timestamp.

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
Changes in v2:
- Drop Emil's idpf_vport_open race fix for now.
- Add my signature.
- Link to v1: https://lore.kernel.org/r/20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com

---
Jedrzej Jagielski (4):
      ixgbevf: fix getting link speed data for E610 devices
      ixgbe: handle IXGBE_VF_GET_PF_LINK_STATE mailbox operation
      ixgbevf: fix mailbox API compatibility by negotiating supported features
      ixgbe: handle IXGBE_VF_FEATURES_NEGOTIATE mbox cmd

Koichiro Den (1):
      ixgbe: fix too early devlink_free() in ixgbe_remove()

Milena Olech (1):
      idpf: cleanup remaining SKBs in PTP flows

 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h       |  15 ++
 drivers/net/ethernet/intel/ixgbevf/defines.h       |   1 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h       |   7 +
 drivers/net/ethernet/intel/ixgbevf/mbx.h           |   8 +
 drivers/net/ethernet/intel/ixgbevf/vf.h            |   1 +
 drivers/net/ethernet/intel/idpf/idpf_ptp.c         |   3 +
 .../net/ethernet/intel/idpf/idpf_virtchnl_ptp.c    |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |  79 +++++++++
 drivers/net/ethernet/intel/ixgbevf/ipsec.c         |  10 ++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |  34 +++-
 drivers/net/ethernet/intel/ixgbevf/vf.c            | 182 +++++++++++++++++----
 12 files changed, 310 insertions(+), 34 deletions(-)
---
base-commit: daa26ea63c6f848159821cd9b3cbe47cddbb0a1c
change-id: 20251001-jk-iwl-net-2025-10-01-92cd2a626ff7

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


