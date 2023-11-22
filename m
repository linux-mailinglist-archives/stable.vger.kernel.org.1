Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF0D7F45F9
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 13:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344063AbjKVMZA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 07:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344061AbjKVMY7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 07:24:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AA512C;
        Wed, 22 Nov 2023 04:24:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1293B21972;
        Wed, 22 Nov 2023 12:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700655893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPOJ4cZW9SicxkhV98i+lHL4vEObSuLq+CmYa8fj5jE=;
        b=ftzhYpcaSzZuXJf9LgRkYiNT16DxNGNgYxkBHGEqMHw8R/03aUMm/lZd+92cg2MQyKqrbC
        6StNFafH1wSZJwbdfMDjqpYy4fxgpLTbXNaN2ymTO2A7pdsqTd9O2JjLc1FtygjAq/G2tg
        LeU0SUCitqt52laAiQrDsJXtb1bpl+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700655893;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPOJ4cZW9SicxkhV98i+lHL4vEObSuLq+CmYa8fj5jE=;
        b=oN/1qAT61+ieP78HtisRPtJD207pkPkiIfWDl1//zWdEBM6upd2esLhyV1449vH/ZWYVHG
        HH8vZIgA7g3h6ABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C35A013461;
        Wed, 22 Nov 2023 12:24:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4NXZLhTzXWU2TAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 22 Nov 2023 12:24:52 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        cai.huoqing@linux.dev
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, stable@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 02/14] drm: Fix TODO list mentioning non-KMS drivers
Date:   Wed, 22 Nov 2023 13:09:31 +0100
Message-ID: <20231122122449.11588-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231122122449.11588-1-tzimmermann@suse.de>
References: <20231122122449.11588-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.02
X-Spamd-Result: default: False [-2.02 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         REPLY(-4.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[12];
         MID_CONTAINS_FROM(1.00)[];
         FREEMAIL_TO(0.00)[gmail.com,ffwll.ch,linux.intel.com,kernel.org,linux.dev];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.72)[93.26%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Non-KMS drivers have been removed from DRM. Update the TODO list
accordingly.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: a276afc19eec ("drm: Remove some obsolete drm pciids(tdfx, mga, i810, savage, r128, sis, via)")
Cc: Cai Huoqing <cai.huoqing@linux.dev>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.3+
Cc: linux-doc@vger.kernel.org
---
 Documentation/gpu/todo.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index b62c7fa0c2bcc..3bdb8787960be 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -337,8 +337,8 @@ connector register/unregister fixes
 
 Level: Intermediate
 
-Remove load/unload callbacks from all non-DRIVER_LEGACY drivers
----------------------------------------------------------------
+Remove load/unload callbacks
+----------------------------
 
 The load/unload callbacks in struct &drm_driver are very much midlayers, plus
 for historical reasons they get the ordering wrong (and we can't fix that)
@@ -347,8 +347,7 @@ between setting up the &drm_driver structure and calling drm_dev_register().
 - Rework drivers to no longer use the load/unload callbacks, directly coding the
   load/unload sequence into the driver's probe function.
 
-- Once all non-DRIVER_LEGACY drivers are converted, disallow the load/unload
-  callbacks for all modern drivers.
+- Once all drivers are converted, remove the load/unload callbacks.
 
 Contact: Daniel Vetter
 
-- 
2.42.1

