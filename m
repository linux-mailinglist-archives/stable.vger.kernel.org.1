Return-Path: <stable+bounces-18330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A0E84824B
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0691F277A0
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BD8481DB;
	Sat,  3 Feb 2024 04:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YWKA0NsR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB37482C3;
	Sat,  3 Feb 2024 04:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933720; cv=none; b=an1IHZjis2Ruv8lJWlDnwFHxx8Y98wqs0dCYgNdyzHIvItHr68SvqAeoN7haB5fHM3ChoxOwK6OvKO7SecUFdY770HNjxCjSW/kvMRGrFgeDcLEeh8vRGsWJNCa7u6PoLy40lGw5Zjf/6zAos7BxesAasso0YlFzE3SxbBabAH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933720; c=relaxed/simple;
	bh=izSrFqt+4gGrmoxFKWc28u0poeWk9svdqB9fI6X1xsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOD/veWB5wVhHnscANvO2pWd+FgOv7gDhRKISwOajJUv7n/0Kqp9KRd0YEmhpCxRP2/8OKxamDY++SbMg0oqkFOpBUNyIXpPAw+/p/qAXGyaRbfO2kddlPSd9M2b9FIB7FUXNX6gdVdfSbv1voO2QKtWPm7HaXLNBFa32IECWIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YWKA0NsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CC3C43394;
	Sat,  3 Feb 2024 04:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933719;
	bh=izSrFqt+4gGrmoxFKWc28u0poeWk9svdqB9fI6X1xsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YWKA0NsRL/rQ0Uba8lTNJVCXT7xfqNcfhcc/C7nNzcIjaxjd+/VZIFqFNtnZtX/oK
	 uNWakNJAuoLlMID4mZLpXGzq6GYUMT3XgrfuzYew2rdBL5a8vjzgSjV5gtJzo/NlN6
	 bMQaFErWBZZUrIPvaSKrI1u9vjBI5kl/y2Yb4/E8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Gray <jsg@jsg.id.au>
Subject: [PATCH 6.6 318/322] Revert "drm/amd/display: Disable PSR-SU on Parade 0803 TCON again"
Date: Fri,  2 Feb 2024 20:06:55 -0800
Message-ID: <20240203035409.310551998@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Gray <jsg@jsg.id.au>

This reverts commit 107a11637f43e7cdcca96c09525481e38b004455.

duplicated a change made in 6.6.8
a8f922ad2f76a53383982132ee44d123b72533c5

Cc: stable@vger.kernel.org # 6.6
Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -841,8 +841,6 @@ bool is_psr_su_specific_panel(struct dc_
 				isPSRSUSupported = false;
 			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
 				isPSRSUSupported = false;
-			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
-				isPSRSUSupported = false;
 			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
 				isPSRSUSupported = true;
 		}



