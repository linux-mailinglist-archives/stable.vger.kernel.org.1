Return-Path: <stable+bounces-165236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F0EB15C25
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11097A3623
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212C627467A;
	Wed, 30 Jul 2025 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UOz0EHjq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F54274666;
	Wed, 30 Jul 2025 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868335; cv=none; b=uinJu725gJVxlkvKbj1HvIA/HKtoiMLKsJAI5RAZFYgaCSUBNrn7eA0QaX/TyDgA1JKfVtwMhoo1KkO835hRWyFo6kI2nhBb4IuTiliwAaXCxjOpdvQSLkW6mDkotiFgaadA1dg9P2amSQqSgdo+0kNpgjKG9GVTTEn/4vUJnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868335; c=relaxed/simple;
	bh=UjSAH+AUSduLobz9ttuIkEIWqJVeb3a5eu0YBJHCqCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flKOfy43CS7aJyret0HzEVRM25R/Tk8Z8owArDLuzrMQxTSbyavHwS2MH8dHLjWpRWHlgA8wn3+7QEHhKSvPLO9Y3ILsFx5gvngevkG1R5O7nZZLTWemQuTtv6b6XnCrK1PegAtzdFL6BsnKD2UOpIvdmhhgKOm3ftpuMRLIm1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UOz0EHjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D447C4CEE7;
	Wed, 30 Jul 2025 09:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753868335;
	bh=UjSAH+AUSduLobz9ttuIkEIWqJVeb3a5eu0YBJHCqCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOz0EHjq6YN1wuqe3hx35CUnfsCBAB9OAFFHACtifJaPUqk4ejSbtVaJzbNY7x6Rh
	 FuvMWjVIQ5GvopIl9PAJ+gaIZi92iV9eUwhEMGxEgQx/CiX6UHFOVNR5t3Rm1xUhke
	 x0DV1xjePXL7PHyrCG9er9fwNFcl2nbPq52asRKA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacek Kowalski <jacek@jacekk.info>,
	Simon Horman <horms@kernel.org>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH 6.6 38/76] e1000e: disregard NVM checksum on tgp when valid checksum bit is not set
Date: Wed, 30 Jul 2025 11:35:31 +0200
Message-ID: <20250730093228.314259311@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093226.854413920@linuxfoundation.org>
References: <20250730093226.854413920@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacek Kowalski <jacek@jacekk.info>

commit 536fd741c7ac907d63166cdae1081b1febfab613 upstream.

As described by Vitaly Lifshits:

> Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the
> driver cannot perform checksum validation and correction. This means
> that all NVM images must leave the factory with correct checksum and
> checksum valid bit set. Since Tiger Lake devices were the first to have
> this lock, some systems in the field did not meet this requirement.
> Therefore, for these transitional devices we skip checksum update and
> verification, if the valid bit is not set.

Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")
Cc: stable@vger.kernel.org
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -4274,6 +4274,8 @@ static s32 e1000_validate_nvm_checksum_i
 			ret_val = e1000e_update_nvm_checksum(hw);
 			if (ret_val)
 				return ret_val;
+		} else if (hw->mac.type == e1000_pch_tgp) {
+			return 0;
 		}
 	}
 



