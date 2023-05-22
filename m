Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625E170C91E
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbjEVTpV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjEVTpG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A457102
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B03A62A5F
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16942C433EF;
        Mon, 22 May 2023 19:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784701;
        bh=YiOsMtl98E05Kazdf4l0D33RTjcr/FcSs8FHjbYQngk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GwDTKbJ3OOyqdHr592E77/vIFdoVYhU3Yy/XqAV3A23YltEyKh0R/ieKrQTpEHLmW
         6DAMFbm0PdQV+vSVxCUgxklrrutQXo85nmB+UgBTj0EHTaKprBPm6Nu0VEFbXT+gKz
         eK8bwFf6Zle60CJhYrCI7c0qqyPd6y8a1Ct+cGoU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ivan Orlov <ivan.orlov0322@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 173/364] KVM: selftests: Add malloc failure check in vcpu_save_state
Date:   Mon, 22 May 2023 20:07:58 +0100
Message-Id: <20230522190417.048471060@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Ivan Orlov <ivan.orlov0322@gmail.com>

[ Upstream commit 735b0e0f2d001b7ed9486db84453fb860e764a4d ]

There is a 'malloc' call in vcpu_save_state function, which can
be unsuccessful. This patch will add the malloc failure checking
to avoid possible null dereference and give more information
about test fail reasons.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Link: https://lore.kernel.org/r/20230322144528.704077-1-ivan.orlov0322@gmail.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index c39a4353ba194..827647ff3d41b 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -954,6 +954,7 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vcpu *vcpu)
 	vcpu_run_complete_io(vcpu);
 
 	state = malloc(sizeof(*state) + msr_list->nmsrs * sizeof(state->msrs.entries[0]));
+	TEST_ASSERT(state, "-ENOMEM when allocating kvm state");
 
 	vcpu_events_get(vcpu, &state->events);
 	vcpu_mp_state_get(vcpu, &state->mp_state);
-- 
2.39.2



