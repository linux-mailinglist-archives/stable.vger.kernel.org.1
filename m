Return-Path: <stable+bounces-1878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C297F81CD
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77DE5B223D7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41033364DE;
	Fri, 24 Nov 2023 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MlvHnVf4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B4733076;
	Fri, 24 Nov 2023 19:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D706AC433C9;
	Fri, 24 Nov 2023 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852496;
	bh=cTih9LWrI02GqQDG+Rhh/2IRiCCajdv+yjWJpnxXvxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MlvHnVf4sllUdHk1G7x/q4uFXBYA+js+dv+kUBT2dox5ik2NAgm77ufy9qAXw1VwE
	 pvIp1yLqbQcLd2uK0p4wT7nwovhGXFopTht+IhXZYPAJjYps0ajClyWoS4svNl6mg9
	 nEH/mkJB4aeqyU5vJUqM8gCcKPtdcarMLkapH5vs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 6.1 359/372] drm/i915: Fix potential spectre vulnerability
Date: Fri, 24 Nov 2023 17:52:26 +0000
Message-ID: <20231124172022.266971141@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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



