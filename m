Return-Path: <stable+bounces-110395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA622A1BC5F
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7B13A4E34
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 18:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3AF224B0A;
	Fri, 24 Jan 2025 18:48:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4BD224AF9;
	Fri, 24 Jan 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744526; cv=none; b=JXPFkmDcEruPnjCQcaBEKKWlmZEx/0m4L6EIjVgaTGQf4mBvWa0pP8PGFTqHpd5NPw4VP7cBC/xXOwsSRoJsoSVKZg/b8PUAkpkJayCFLca02TYzvRIbCIoXd3JeKA66rfWBuGrRpgYtD5pfDWRMEqXDwdyErJUMqLpATYPQcto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744526; c=relaxed/simple;
	bh=gCTK4nH4K3yYB3x2QcYXNxIDAeH7NThCYKtYRs9kmYE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=R+m6TpLm+41QKzNEvuE93uMJWWugM7SZDloi/yVq+bipGaXaQ04RMnLWv+qYeNb0BCDvjNexqn4/kLZ1wDsgJyve42+FYN9g+F4jkXY2s5cYdQTSncdktFxawDUhiUIRlFApJ10kTc4Bu0ss6JfLiY7Oup+zhSC0By9pehNZhfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76884C4CEE5;
	Fri, 24 Jan 2025 18:48:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tbOjh-00000001FC8-2Fy3;
	Fri, 24 Jan 2025 13:48:57 -0500
Message-ID: <20250124184857.386752437@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 24 Jan 2025 13:48:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 stable@vger.kernel.org,
 Luis Goncalves <lgoncalv@redhat.com>
Subject: [for-next][PATCH 07/14] rtla/osnoise: Distinguish missing workload option
References: <20250124184835.052017152@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

osnoise_set_workload returns -1 for both missing OSNOISE_WORKLOAD option
and failure in setting the option.

Return -1 for missing and -2 for failure to distinguish them.

Cc: stable@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20250107144823.239782-2-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 245e9344932b..699a83f538a8 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -867,7 +867,7 @@ int osnoise_set_workload(struct osnoise_context *context, bool onoff)
 
 	retval = osnoise_options_set_option("OSNOISE_WORKLOAD", onoff);
 	if (retval < 0)
-		return -1;
+		return -2;
 
 	context->opt_workload = onoff;
 
-- 
2.45.2



