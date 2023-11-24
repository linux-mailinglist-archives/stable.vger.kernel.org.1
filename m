Return-Path: <stable+bounces-1478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C7D7F7FE1
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 242BAB218B5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAEF33CFD;
	Fri, 24 Nov 2023 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n1B07Wlu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12D2D787;
	Fri, 24 Nov 2023 18:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4ECC433C7;
	Fri, 24 Nov 2023 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851500;
	bh=3MgmTCm7vFKhD9WsCESMmFuHpkggM2hr6ZY37TihiU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1B07WluM10x8hgS3DNPGWHfShd6D8YNGH8NOVrC7Sg08EL2OoNZ76xT7O0RNOYPh
	 Jh091BZPVzhpzX2JjwpZMz3sMy2CapvIr+ZBuPgbri1UV25PMlu0X9E71uM/tAOVm1
	 QYV4aDHlAm5vDafut4o7anJcDTxNBpeNnZ8iIp1k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 6.5 473/491] drm/i915: Fix potential spectre vulnerability
Date: Fri, 24 Nov 2023 17:51:49 +0000
Message-ID: <20231124172038.840631328@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunwu Chan <chentao@kylinos.cn>

commit 1a8e9bad6ef563c28ab0f8619628d5511be55431 upstream.

Fix smatch warning:
drivers/gpu/drm/i915/gem/i915_gem_context.c:847 set_proto_ctx_sseu()
warn: potential spectre issue 'pc->user_engines' [r] (local cap)

Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
Cc: <stable@vger.kernel.org> # v5.15+
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231103110922.430122-1-tvrtko.ursulin@linux.intel.com
(cherry picked from commit 27b086382c22efb7e0a16442f7bdc2e120108ef3)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -844,6 +844,7 @@ static int set_proto_ctx_sseu(struct drm
 		if (idx >= pc->num_user_engines)
 			return -EINVAL;
 
+		idx = array_index_nospec(idx, pc->num_user_engines);
 		pe = &pc->user_engines[idx];
 
 		/* Only render engine supports RPCS configuration. */



