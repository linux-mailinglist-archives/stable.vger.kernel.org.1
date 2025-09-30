Return-Path: <stable+bounces-182379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E43BAD7F1
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7807A1885AA2
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD9C217F55;
	Tue, 30 Sep 2025 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IcfxAz5w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85EE846F;
	Tue, 30 Sep 2025 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244753; cv=none; b=AowBMCSsdW5/YGPJLPpQLGBtFQjWLGPQBAZ7LxCv4It5C7QyWDl0BiFRWW34KfxffdUaVik7KyWDGfNcscQQbAFwVouZNPhN4NjNP81UZRfDYG/r2oGYehmTL/jrGyB5eC0LlqgQCBlkcOH7z/NHBUF+Ui9WzSTW7aTRNXdvhK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244753; c=relaxed/simple;
	bh=vwl3vUffvUDL91cX+cJRMPMtF6KKhZaPGVQJkr+k1k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcI7qNX8Ul+i2QBTCib/avcKvWD+JKDwvMvsgU+D2a3Ci58wT8Vk4QEkP4lGZIMH+4F7VJ7S7ugsAVU/WB7PG95PQzl4Q0UJG5AYniq9jSmsNkyV/8uhZ8NTS/U7/lydlt4rj1PFXgjV1VCCj+jarEjgPpH18dnX8o+i2ARKrp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IcfxAz5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663AEC4CEF0;
	Tue, 30 Sep 2025 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244752;
	bh=vwl3vUffvUDL91cX+cJRMPMtF6KKhZaPGVQJkr+k1k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IcfxAz5wqPpAQQnKseJEMFZ3otQNL36yxEMDI2rrbOZwucgMsCUX9pOVSxpAfJJSG
	 M6nb+hZ/dPGPwYMJprl9rZxMhZqx2DEqPzYfSOaKJ+Aovc3oe8vkW22Jl4Xy0Rr9sa
	 j9ULrFVnhR655EjUauGRw+xR19B8D7a2B2+oFl6Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Kamakshi Nellore <nellorex.kamakshi@intel.com>
Subject: [PATCH 6.16 104/143] i40e: fix idx validation in config queues msg
Date: Tue, 30 Sep 2025 16:47:08 +0200
Message-ID: <20250930143835.377074116@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
References: <20250930143831.236060637@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

commit f1ad24c5abe1eaef69158bac1405a74b3c365115 upstream.

Ensure idx is within range of active/initialized TCs when iterating over
vf->ch[idx] in i40e_vc_config_queues_msg().

Fixes: c27eac48160d ("i40e: Enable ADq and create queue channel/s on VF")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Kamakshi Nellore <nellorex.kamakshi@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2398,7 +2398,7 @@ static int i40e_vc_config_queues_msg(str
 		}
 
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = -ENODEV;
 				goto error_param;
 			}
@@ -2419,7 +2419,7 @@ static int i40e_vc_config_queues_msg(str
 		 * to its appropriate VSIs based on TC mapping
 		 */
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = -ENODEV;
 				goto error_param;
 			}



