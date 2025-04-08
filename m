Return-Path: <stable+bounces-129521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770B4A80011
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93E33AC3B5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62352686AB;
	Tue,  8 Apr 2025 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JxCTosFf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60823224F6;
	Tue,  8 Apr 2025 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111254; cv=none; b=Lph8WMpVbqG8dQ9nmGqTuRy10M/vY7f5nUjjV7FGXQSQs45nt9Z12KLtWjfezmuAgxT2Y05Sj/QdsA7UbgYxNh47173tmBhlDqL9NLf+jxAXoBBtW4QBps7TinER+2Oe//iIX6z8H+zVbh8AcgLtir1Ufup1Wp/a8ez5+Yx7HQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111254; c=relaxed/simple;
	bh=GGon4WWpdV18zSnIuN682l04Y1Zc95DFonULJ7aJKjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdD7T8Wk6MbO0aNh45xGY9dmZjubw0c/91tKIcmX7o2tyJH2ZGI/1c2CKVClvTzpofYecfboGb6F/YSKGIJ2awQzgok7X/qc6kpDxoL16obdD7gUtBoB9Hf7abHU72TI9+g4cj3Q1nUR92acvJXp1sTTXNYjN9YCOR/z4J5OxSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JxCTosFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0283C4CEE5;
	Tue,  8 Apr 2025 11:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111254;
	bh=GGon4WWpdV18zSnIuN682l04Y1Zc95DFonULJ7aJKjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxCTosFfVXw7pB1zDD1mndfvjgRDLc12TUaM0h1MBl/HJa7CiSCvRQdKzJfU1N+qG
	 q9phHMMHa1s3giP6F4vaCg7w/593ebFdRj+Dxujgg9CZRpoNPQcGjJoEs+5+mBJ4yX
	 abqa7/KofknVMotSqJ3Vxvy4B9+uMYiewDb2uwh4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 365/731] of: property: Increase NR_FWNODE_REFERENCE_ARGS
Date: Tue,  8 Apr 2025 12:44:22 +0200
Message-ID: <20250408104922.766047781@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit eb50844d728f11e87491f7c7af15a4a737f1159d ]

Currently, the following two macros have different values:

// The maximal argument count for firmware node reference
 #define NR_FWNODE_REFERENCE_ARGS	8
// The maximal argument count for DT node reference
 #define MAX_PHANDLE_ARGS 16

It may cause firmware node reference's argument count out of range if
directly assign DT node reference's argument count to firmware's.

drivers/of/property.c:of_fwnode_get_reference_args() is doing the direct
assignment, so may cause firmware's argument count @args->nargs got out
of range, namely, in [9, 16].

Fix by increasing NR_FWNODE_REFERENCE_ARGS to 16 to meet DT requirement.
Will align both macros later to avoid such inconsistency.

Fixes: 3e3119d3088f ("device property: Introduce fwnode_property_get_reference_args")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Link: https://lore.kernel.org/r/20250225-fix_arg_count-v4-1-13cdc519eb31@quicinc.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fwnode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 0731994b9d7c8..6fa0a268d5382 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -91,7 +91,7 @@ struct fwnode_endpoint {
 #define SWNODE_GRAPH_PORT_NAME_FMT		"port@%u"
 #define SWNODE_GRAPH_ENDPOINT_NAME_FMT		"endpoint@%u"
 
-#define NR_FWNODE_REFERENCE_ARGS	8
+#define NR_FWNODE_REFERENCE_ARGS	16
 
 /**
  * struct fwnode_reference_args - Fwnode reference with additional arguments
-- 
2.39.5




