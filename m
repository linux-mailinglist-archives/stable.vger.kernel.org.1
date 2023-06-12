Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45A472BFEF
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjFLKsL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFLKrv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:47:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B226E64
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:32:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ADBE623CE
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A96C433A0;
        Mon, 12 Jun 2023 10:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565959;
        bh=Tyco2/frODmM11+aSp8BZ4JqeKefzybVQDxmZCHymYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H8De3rFyFG0uVsmBtjUKy3GOiQ++CW5N6gS5lsWa/Ja8KYRGuOHOTGZjPiwTO/L90
         UPpulh5Hy/BkkD7Mquc1CqVeiOFh9jtn1a4HPPxI0ErHqP/A407kS/pBK4JRYXH1Tu
         z7hAbr6K+Qm505Cqx3Mf1vCDjcf4ZHUb+9jzJ+GU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev
Subject: [PATCH 5.10 11/68] i40e: fix build warning in ice_fltr_add_mac_to_list()
Date:   Mon, 12 Jun 2023 12:26:03 +0200
Message-ID: <20230612101658.942299030@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
References: <20230612101658.437327280@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Not upstream as this was fixed in a much larger change in commit
5e24d5984c80 ("ice: Use int for ice_status")

The function ice_fltr_add_mac_to_list() has the wrong prototype match
from the .h file to the .c declaration, so fix it up, otherwise gcc-13
complains (rightfully) that the type is incorrect.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_fltr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/ice/ice_fltr.c
+++ b/drivers/net/ethernet/intel/ice/ice_fltr.c
@@ -128,7 +128,7 @@ void ice_fltr_remove_all(struct ice_vsi
  * @mac: MAC address to add
  * @action: filter action
  */
-int
+enum ice_status
 ice_fltr_add_mac_to_list(struct ice_vsi *vsi, struct list_head *list,
 			 const u8 *mac, enum ice_sw_fwd_act_type action)
 {


