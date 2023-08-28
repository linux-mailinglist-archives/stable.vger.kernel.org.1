Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEC878AD91
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjH1Ktd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjH1KtE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D9ECC6
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:48:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94C8964215
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E1DC433C7;
        Mon, 28 Aug 2023 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219728;
        bh=d2hiszxF9knRTVMReMZN5WwNlNU4+xpFzVPbEkE9ouU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XbMSFs7kqZq5hTC+MAkXZROKfbp8mCmeRNj86SWB2rshMfvBOnDD1i+dq+XadDxgw
         Vf6z/PfWxrVpiN1Gml3jmAOYWAbhlB7H1xYnW4FV3qEW9PKFWJoq77Y0BX05LLG7kX
         k7kkpr4fCzqU8c4XFS38dfLtuuelC2fmUaa3IlrY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5.10 51/84] batman-adv: Do not get eth header before batadv_check_management_packet
Date:   Mon, 28 Aug 2023 12:14:08 +0200
Message-ID: <20230828101151.002487185@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
References: <20230828101149.146126827@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Remi Pommarel <repk@triplefau.lt>

commit eac27a41ab641de074655d2932fc7f8cdb446881 upstream.

If received skb in batadv_v_elp_packet_recv or batadv_v_ogm_packet_recv
is either cloned or non linearized then its data buffer will be
reallocated by batadv_check_management_packet when skb_cow or
skb_linearize get called. Thus geting ethernet header address inside
skb data buffer before batadv_check_management_packet had any chance to
reallocate it could lead to the following kernel panic:

  Unable to handle kernel paging request at virtual address ffffff8020ab069a
  Mem abort info:
    ESR = 0x96000007
    EC = 0x25: DABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
    FSC = 0x07: level 3 translation fault
  Data abort info:
    ISV = 0, ISS = 0x00000007
    CM = 0, WnR = 0
  swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000040f45000
  [ffffff8020ab069a] pgd=180000007fffa003, p4d=180000007fffa003, pud=180000007fffa003, pmd=180000007fefe003, pte=0068000020ab0706
  Internal error: Oops: 96000007 [#1] SMP
  Modules linked in: ahci_mvebu libahci_platform libahci dvb_usb_af9035 dvb_usb_dib0700 dib0070 dib7000m dibx000_common ath11k_pci ath10k_pci ath10k_core mwl8k_new nf_nat_sip nf_conntrack_sip xhci_plat_hcd xhci_hcd nf_nat_pptp nf_conntrack_pptp at24 sbsa_gwdt
  CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.15.42-00066-g3242268d425c-dirty #550
  Hardware name: A8k (DT)
  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : batadv_is_my_mac+0x60/0xc0
  lr : batadv_v_ogm_packet_recv+0x98/0x5d0
  sp : ffffff8000183820
  x29: ffffff8000183820 x28: 0000000000000001 x27: ffffff8014f9af00
  x26: 0000000000000000 x25: 0000000000000543 x24: 0000000000000003
  x23: ffffff8020ab0580 x22: 0000000000000110 x21: ffffff80168ae880
  x20: 0000000000000000 x19: ffffff800b561000 x18: 0000000000000000
  x17: 0000000000000000 x16: 0000000000000000 x15: 00dc098924ae0032
  x14: 0f0405433e0054b0 x13: ffffffff00000080 x12: 0000004000000001
  x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
  x8 : 0000000000000000 x7 : ffffffc076dae000 x6 : ffffff8000183700
  x5 : ffffffc00955e698 x4 : ffffff80168ae000 x3 : ffffff80059cf000
  x2 : ffffff800b561000 x1 : ffffff8020ab0696 x0 : ffffff80168ae880
  Call trace:
   batadv_is_my_mac+0x60/0xc0
   batadv_v_ogm_packet_recv+0x98/0x5d0
   batadv_batman_skb_recv+0x1b8/0x244
   __netif_receive_skb_core.isra.0+0x440/0xc74
   __netif_receive_skb_one_core+0x14/0x20
   netif_receive_skb+0x68/0x140
   br_pass_frame_up+0x70/0x80
   br_handle_frame_finish+0x108/0x284
   br_handle_frame+0x190/0x250
   __netif_receive_skb_core.isra.0+0x240/0xc74
   __netif_receive_skb_list_core+0x6c/0x90
   netif_receive_skb_list_internal+0x1f4/0x310
   napi_complete_done+0x64/0x1d0
   gro_cell_poll+0x7c/0xa0
   __napi_poll+0x34/0x174
   net_rx_action+0xf8/0x2a0
   _stext+0x12c/0x2ac
   run_ksoftirqd+0x4c/0x7c
   smpboot_thread_fn+0x120/0x210
   kthread+0x140/0x150
   ret_from_fork+0x10/0x20
  Code: f9403844 eb03009f 54fffee1 f94

Thus ethernet header address should only be fetched after
batadv_check_management_packet has been called.

Fixes: 0da0035942d4 ("batman-adv: OGMv2 - add basic infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_v_elp.c |    3 ++-
 net/batman-adv/bat_v_ogm.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -509,7 +509,7 @@ int batadv_v_elp_packet_recv(struct sk_b
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_elp_packet *elp_packet;
 	struct batadv_hard_iface *primary_if;
-	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	struct ethhdr *ethhdr;
 	bool res;
 	int ret = NET_RX_DROP;
 
@@ -517,6 +517,7 @@ int batadv_v_elp_packet_recv(struct sk_b
 	if (!res)
 		goto free_skb;
 
+	ethhdr = eth_hdr(skb);
 	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
 		goto free_skb;
 
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -998,7 +998,7 @@ int batadv_v_ogm_packet_recv(struct sk_b
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_ogm2_packet *ogm_packet;
-	struct ethhdr *ethhdr = eth_hdr(skb);
+	struct ethhdr *ethhdr;
 	int ogm_offset;
 	u8 *packet_pos;
 	int ret = NET_RX_DROP;
@@ -1012,6 +1012,7 @@ int batadv_v_ogm_packet_recv(struct sk_b
 	if (!batadv_check_management_packet(skb, if_incoming, BATADV_OGM2_HLEN))
 		goto free_skb;
 
+	ethhdr = eth_hdr(skb);
 	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
 		goto free_skb;
 


