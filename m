Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7D3735344
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjFSKno (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjFSKnZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:43:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0277A1BF1
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 887E160B51
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9188DC433CA;
        Mon, 19 Jun 2023 10:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171379;
        bh=AB853Nfcs48OHRYDzF9ogMoL+ppGUf+BJWz06PgcIqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PG0krEyPPBEf51VD+ck8cklT34c/kXhK6r0SjOBZh7gGfEZxsnyPAwQAVec+z9thL
         OnN2ekx+5J2FOY210WGAfSBRBF5RRNMPU5NyrOw70KdVPXPB2sXfhYxL+sfKrtMZQN
         FsbhhqDuHIGN4WON7Prit8jvW31RGYu3zYA9SbEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 010/166] of: overlay: Fix missing of_node_put() in error case of init_overlay_changeset()
Date:   Mon, 19 Jun 2023 12:28:07 +0200
Message-ID: <20230619102155.173960819@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

[ Upstream commit 39affd1fdf65983904fafc07cf607cff737eaf30 ]

In init_overlay_changeset(), the variable "node" is from
of_get_child_by_name(), and the "node" should be discarded in error case.

Fixes: d1651b03c2df ("of: overlay: add overlay symbols to live device tree")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/20230602020502.11693-1-hayashi.kunihiko@socionext.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/overlay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index ed4e6c144a681..5289975bad708 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -811,6 +811,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs)
 		if (!fragment->target) {
 			pr_err("symbols in overlay, but not in live tree\n");
 			ret = -EINVAL;
+			of_node_put(node);
 			goto err_out;
 		}
 
-- 
2.39.2



