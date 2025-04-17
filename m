Return-Path: <stable+bounces-134242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE598A929E5
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7F01B640B1
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC3255241;
	Thu, 17 Apr 2025 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0mEsZbXe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B12C433A5;
	Thu, 17 Apr 2025 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915533; cv=none; b=oavbTG9bOdZ0ZmZieAQxeNYGG7MFs6ObR/5Brfx0cD6f1lmkxQojE3uFqa0VQnBJsJhiV8bWbEtuw4vFwWa79L5I6iNxb8vH09ZETebD9ENsi4A+qLtqXSG+eNktvrfBaHRiNdB4Ge5pqD5V6ZBQNoFudzpDjbbIPyOLPhKqOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915533; c=relaxed/simple;
	bh=OAUXzkNYVauHRMiJDGfSIugqP7gtIZuVtn0sBu8QcjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njknNwN2RMtoLyFK6SXsEaveq+njXkLJO91PIgzmN0Ll2QJJbrT9yEr58hJj19BRLYobE3CCVW7mqs9FsD81sBdkWMqMYQUAqCwJHXigoMbPdYx8ks2GkipJvffsCCnxcyGTabiT6qX86GkayiD+CYIme6jTnlr5rspHHZ14QYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0mEsZbXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C82BC4CEE7;
	Thu, 17 Apr 2025 18:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915533;
	bh=OAUXzkNYVauHRMiJDGfSIugqP7gtIZuVtn0sBu8QcjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0mEsZbXerd+qsxvmRS6+XeI7JENAsO6waaHohz/vIj9NVIe1tzsL2bA8shVgcDXi7
	 Ka4h5nowwC0vkLs39Nd9R//D/8y9DmJoojYelOcT1cvtKa+2NkYyOYudyqY4nCYZwn
	 X06C+xpAidWuXZTEoh1X1QAoeF4uShbqdvYM8o6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shekhar Chauhan <shekhar.chauhan@intel.com>,
	Clint Taylor <Clinton.A.Taylor@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 127/393] drm/xe/bmg: Add new PCI IDs
Date: Thu, 17 Apr 2025 19:48:56 +0200
Message-ID: <20250417175112.698591018@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shekhar Chauhan <shekhar.chauhan@intel.com>

[ Upstream commit fa8ffaae1b15236b8afb0fbbc04117ff7c900a83 ]

Add 3 new PCI IDs for BMG.

v2: Fix typo -> Replace '.' with ','

Signed-off-by: Shekhar Chauhan <shekhar.chauhan@intel.com>
Reviewed-by: Clint Taylor <Clinton.A.Taylor@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250128162015.3288675-1-shekhar.chauhan@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/intel/i915_pciids.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/intel/i915_pciids.h b/include/drm/intel/i915_pciids.h
index f35534522d333..dacea289acaf5 100644
--- a/include/drm/intel/i915_pciids.h
+++ b/include/drm/intel/i915_pciids.h
@@ -809,6 +809,9 @@
 	MACRO__(0xE20B, ## __VA_ARGS__), \
 	MACRO__(0xE20C, ## __VA_ARGS__), \
 	MACRO__(0xE20D, ## __VA_ARGS__), \
-	MACRO__(0xE212, ## __VA_ARGS__)
+	MACRO__(0xE210, ## __VA_ARGS__), \
+	MACRO__(0xE212, ## __VA_ARGS__), \
+	MACRO__(0xE215, ## __VA_ARGS__), \
+	MACRO__(0xE216, ## __VA_ARGS__)
 
 #endif /* _I915_PCIIDS_H */
-- 
2.39.5




