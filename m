Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2470B734E3A
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 10:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjFSIoL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 04:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjFSIn7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 04:43:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7295B19A3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=6byDLFsn6rqTRYr11z3R/1GJNXGe98ue2+yPQbylj4g=; t=1687164113; x=1688373713; 
        b=FWT+oF5qi7bbyLYyiPY1PtZ27PvgkeBZ6jGgrEcD/UeRJMFkqG0vGzQYZcjbm7+4EqVyv66ELCe
        A3bg/todF+s8StI3qyOk3KYA53y4fr3X8VtXVyN2/WPzBMR1vLlKIdP0rlbD2HG0MuoGVcUvz5Z8w
        6hlPus+5dIghvCOTXSQiT/3oWts5lAJoRd83NBgHjMx2+tE+p3CrBZ4fY/I412oz97u9uMyat9Gcy
        3M1d50uxRwqWbtbnLNztFXoBm2Ey3OC2WziFWHcRojFH/TJMiy04Q0de4XQcW87xwfeTO9V/G1v7/
        64VWPhz1pxuihLFevdFqT2nJr4Q7W/smAegQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qBASN-00BFmx-1r
        for stable@vger.kernel.org;
        Mon, 19 Jun 2023 10:41:51 +0200
Message-ID: <c2d46fa2647e616a4e2352479619cd0a0b5a14b6.camel@sipsolutions.net>
Subject: 5.10: fixing b58294ce1a8a ("um: Allow PM with suspend-to-idle")
From:   Johannes Berg <johannes@sipsolutions.net>
To:     stable@vger.kernel.org
Date:   Mon, 19 Jun 2023 10:41:50 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Not sure why this was backported in the first place, but if so you'd
also need 1fb1abc83636 ("um: Fix build w/o CONFIG_PM_SLEEP").

I think b58294ce1a8a ("um: Allow PM with suspend-to-idle") should just
be reverted, but picking up the fix for it also works.

Robot keeps reporting to me that it's broken :)

Thanks,
johannes
