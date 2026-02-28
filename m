Return-Path: <stable+bounces-220266-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBEkJlYvo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220266-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:09:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F39151C57A2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0726B321AE1C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ECA47DD62;
	Sat, 28 Feb 2026 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QifdZsQN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D137D7BB;
	Sat, 28 Feb 2026 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300169; cv=none; b=Qr/XtAF4mxsVgmnM37Q4GGFXVo879Kg6oN2HvZZ1fKR34wl3/Uxi8VVrC+PMov4AhFkRfsm59Cwlgt1JDIAUkcDz0dVNu2aPwzs8jjZox6Ov62WOu4aKtL09Nq6Ys7r5Jm1edIYS/1iUfH+JB4M81rX1fcHsmFUbH3VBXw6qoPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300169; c=relaxed/simple;
	bh=t/qWvLiiZTN9YhktCj57n4lM8XQf8ni+1HTIecX0v1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acMsHo08Zjh8lPzQ+DGHo837hXDKsiKSA2owVRc6wJ/7FaIpnQhAYUhJ/0KUtgTkrEdWd4R2kobjm+eMPEQrQE2gf6RooToEvSo9BAB6BcM1IBFYJSfdZM3BoE3/t2DWNWyEaIYbY4p5/NkCKzmgbE64bMs2OQTx4DesSVfBu0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QifdZsQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D8AC116D0;
	Sat, 28 Feb 2026 17:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300169;
	bh=t/qWvLiiZTN9YhktCj57n4lM8XQf8ni+1HTIecX0v1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QifdZsQNmIG8cZyG44OKQ3h+DdbdH8q2u2DsKKx84czuMd2Iynel+ZDCgRxaFxQmN
	 WiJ2uGLbuj0yZwHTXoSsxB3OOjfCrRwEvwLUYWDtu/j9vrDjZorUpAc1l9D1wbV3mD
	 cEWoAz2Ifi7rgyTmfhoMfIIaZkD0sN2elBwWNU/jWVo4JWGYbfuKCgui4qFBLBq+Ss
	 18Bdt7SuwOfheSWWWs2C3JqiWsRJC/KBIPhCA9DS69gylXRsoj8WyExUSu2yk9jGz1
	 LnaGkqngvNbn/JKJC65iZ8/j5phd2irfISZlBoWcMKL72nv/+Nm01jDV35FAPhjS4Y
	 QoVob4CNoXqug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 188/844] media: ipu6: Always close firmware stream
Date: Sat, 28 Feb 2026 12:21:41 -0500
Message-ID: <20260228173244.1509663-189-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220266-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: F39151C57A2
X-Rspamd-Action: no action

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 2b08b7007e55bd1793a58478d3ecea4fd95849a5 ]

Close the firmware stream even when disabling a stream on an upstream
sub-device fails. This allows the firmware to release resources related to
a stream that is stopped in any case.

Suggested-by: Bingbu Cao <bingbu.cao@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>
Tested-by: Mehdi Djait <mehdi.djait@linux.intel.com> # Dell XPS 9315
Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu6/ipu6-isys-video.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c b/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
index 919b77107cef7..54d861aca0088 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
@@ -1036,11 +1036,10 @@ int ipu6_isys_video_set_streaming(struct ipu6_isys_video *av, int state,
 			sd->name, r_pad->index, stream_mask);
 		ret = v4l2_subdev_disable_streams(sd, r_pad->index,
 						  stream_mask);
-		if (ret) {
+		if (ret)
 			dev_err(dev, "stream off %s failed with %d\n", sd->name,
 				ret);
-			return ret;
-		}
+
 		close_streaming_firmware(av);
 	} else {
 		ret = start_stream_firmware(av, bl);
-- 
2.51.0


