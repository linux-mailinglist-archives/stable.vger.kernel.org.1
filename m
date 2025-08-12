Return-Path: <stable+bounces-167984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B9EB232DB
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249B02A286D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC28B2F4A02;
	Tue, 12 Aug 2025 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BGPLHMQR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3F2DFA3E;
	Tue, 12 Aug 2025 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022651; cv=none; b=mXTU82hTDBsPD1L2GIfoChpZEZFXvrYtDmdw+jmBqmln0PvT6rmBbx4DHNNEmqNjEhCrAITGDLZQrmE6gPk8lWjLWCvIQVivit4VBrNRbEilqOeEHcw/e1YQNXuUrPUuECsbRuOaHiDmUX5JGoU32eMpcKuXoQ4PvpxxRfe/6pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022651; c=relaxed/simple;
	bh=IguVgSroqIDBfp0Q0498E4hd+aLzvVPXiYbRyMl0MYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmNgiQzG6yOQJjFOkeZffsqRvJlLaVSgSvGJ9VcskIYAJXOsDGjwE508h5/CLySW8WgYEoFemSZSx4wbEdirVC9eH0tELTwtiHDzifNgmYt5uSfZP9U7nzhl0aLNX8SMGft840t1DGpBe5M5BdQoxNJTXJqyF78xF3zV7x86fDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BGPLHMQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EC9C4CEF0;
	Tue, 12 Aug 2025 18:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022651;
	bh=IguVgSroqIDBfp0Q0498E4hd+aLzvVPXiYbRyMl0MYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BGPLHMQR8FWFDKL1Q2bZT4a0bD02Ox9ZysZCzQ/DoWauRrrJCPaZm3b97gNL4GbFz
	 3tzQ1tu2QDY9YbjCEHih5831uO+12w7qmxBw2dknq+FQnsCEmRr9ZU/l47cN9O5PP+
	 9ctglesc++yfF1QIFATnohurjnwqXLvZXexelc24=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 211/369] soundwire: stream: restore params when prepare ports fail
Date: Tue, 12 Aug 2025 19:28:28 +0200
Message-ID: <20250812173022.696183863@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit dba7d9dbfdc4389361ff3a910e767d3cfca22587 ]

The bus->params should be restored if the stream is failed to prepare.
The issue exists since beginning. The Fixes tag just indicates the
first commit that the commit can be applied to.

Fixes: 17ed5bef49f4 ("soundwire: add missing newlines in dynamic debug logs")
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20250626060952.405996-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 7aa4900dcf31..6c1e3aed8162 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1414,7 +1414,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 		if (ret < 0) {
 			dev_err(bus->dev, "Prepare port(s) failed ret = %d\n",
 				ret);
-			return ret;
+			goto restore_params;
 		}
 	}
 
-- 
2.39.5




