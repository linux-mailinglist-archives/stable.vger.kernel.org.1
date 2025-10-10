Return-Path: <stable+bounces-183846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 151C9BCB3F6
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 02:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB8514E8A94
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 00:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1E613C3CD;
	Fri, 10 Oct 2025 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7jzUThr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5479F2;
	Fri, 10 Oct 2025 00:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054653; cv=none; b=uHCTIR070qFBkUor6feh9HNRSnxOB4jWgi+PsAsa4DWZcZXCwU/Tel2uOwWJ7Qr7gWjMRgTvXOCTwxaFk5Nkd5RmzJvrZmhOGEiKFdmU06eBQCVp6vB+K8EyUVzMW2VjdLuWOLeH1AIEXsGVdW9fPxpOilRjE5iHJE4EHT78RXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054653; c=relaxed/simple;
	bh=Bt23SmaCVtuXNe02eELEwMDCDlIJIwO67jK/xZq54G8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iwqlSaMh0zJ6UZRhWN8UNZRDsVrRqBFoLRMt0xEVkYfejRVtlUDAt6+D+ndhts2e8xQM5H4BbTilvOAYl3RKM2qyaAe69iDDqoSxmg0otOQ3n3c07Qe8csFG8kcBpQR3xoJJ8R4VB55/hHYEzA28wAXedJgrXtbCSVnwSvUv+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7jzUThr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760054653; x=1791590653;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Bt23SmaCVtuXNe02eELEwMDCDlIJIwO67jK/xZq54G8=;
  b=I7jzUThr+sLi/3ZmjX4+uAlb6aji49Y4Rqv8ZLqAeb6UoaD6M46ItatK
   xvvZqJikhb+w3N/j/5t515vLUSFjqPzioFwlPVmUtTirP9lZbIASi6IaR
   dCj1hN9drvw2bWyaD7gzc/fDF1kl/iNXXml7GECndH54r42XujTrk/jbD
   Rr0kMst4tHS5wTA2auVNRKlVKM57LjhLrifWPGkVi8AX4CsK8tlSgF9Oy
   DfG7eY+C3SgltTFm+/STWjXTCOJycWF2/LLAY8HBqaVCejMxAKKQ4X8K2
   fFyAFC52UsVjK55zrEwWxG/7xWqx1WGkcnQYI49jyabAaH+ZcmHCtCrmu
   g==;
X-CSE-ConnectionGUID: kxyvfV3oQdekhBrvP++2Vg==
X-CSE-MsgGUID: HLaFk0kDRC2tJlT4XYzfjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="62316063"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="62316063"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 17:04:09 -0700
X-CSE-ConnectionGUID: DqCpcbCkR+WD9eADc4oJwg==
X-CSE-MsgGUID: q+RneYEESP+bhByUs17eXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="180858264"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 17:04:09 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net v3 0/6] Intel Wired LAN Driver Updates 2025-10-01
 (idpf, ixgbe, ixgbevf)
Date: Thu, 09 Oct 2025 17:03:45 -0700
Message-Id: <20251009-jk-iwl-net-2025-10-01-v3-0-ef32a425b92a@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGNN6GgC/4XNwQ6CMAwG4FchO1uzDpjOk+9hPMDoZIrDbGRqC
 O/u3ImL8fj/bb/OLJC3FNihmJmnaIMdXQrlpmC6b9yFwHYpM8FFjZwjXG9gnwM4muDbAXJIrRK
 6E40U0pgdS7cPT8a+sntiaZedU9nbMI3+nX9FzKM/bETgUCnTKEV7KTk/WjfRsNXjPYtRrJXyl
 yKSQrVqK6xQY1uvlWVZPnyG2XoFAQAA
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
Cc: Konstantin Ilichev <konstantin.ilichev@intel.com>, 
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Samuel Salin <Samuel.salin@intel.com>, stable@vger.kernel.org, 
 Rafal Romanowski <rafal.romanowski@intel.com>, 
 Koichiro Den <den@valinux.co.jp>, Rinitha S <sx.rinitha@intel.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.15-dev-89294
X-Developer-Signature: v=1; a=openpgp-sha256; l=2889;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Bt23SmaCVtuXNe02eELEwMDCDlIJIwO67jK/xZq54G8=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowXvmVfqjL5nv96Z3VO8VDQ3r6IDWolJ6IWvAo7X2qTW
 Zx8j+9oRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABNxlWZkOB7adm3Gg8ZjK/aV
 zrRbv1NQYxmX1c2FsmlHhKef8VjitYuRYePSx7sevGtntehyOd0//XRaUV7MGX7hPaLq+3Yvz9q
 9jxcA
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
Changes in v3:
- Rebase and verified compilation issues are resolved.
- Configured b4 to exclude undeliverable addresses.
- Link to v2: https://lore.kernel.org/r/20251003-jk-iwl-net-2025-10-01-v2-0-e59b4141c1b5@intel.com

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
base-commit: fea8cdf6738a8b25fccbb7b109b440795a0892cb
change-id: 20251001-jk-iwl-net-2025-10-01-92cd2a626ff7

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


