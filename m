Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3505274668E
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 02:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjGDA0E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 20:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGDA0D (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 20:26:03 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9C1E6
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 17:26:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 537FC3200A1D;
        Mon,  3 Jul 2023 20:25:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 03 Jul 2023 20:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688430357; x=1688516757; bh=LhbkLrJztIBep
        p3f1gSekAL/a18YnQCCcSzp8By4dYk=; b=F04FJufsi2ufwTbCWHNbvBpZdLUWw
        fd9/eXjhiEHU0Yk16gn2BceE7yi1E02XF/joBHDO83sPvQKowfcmILmflZTCbhn0
        DZh/0efF6ve8uq/RtJ6g9ji6o9hq3kZ5Aa2dEX6A6JMVUdSaENE3Rim16sAB5rcN
        tCGcfjvZa5ebM8lFmdwv2yjpAAq5N7SLQ0qA55z2itY+Kt7uUHNbu9SEuUYDDS/a
        yoMoCWIzNx3mhYWdfeS6ToreDy43z6x5+7F7tF0iZg5P37RiZjO+XCTpDezZRh/v
        tLLFiNT5VjCHdXsydJdDaiYpjsS43EPpYviYw+ayziY+52S7JhWcACcHA==
X-ME-Sender: <xms:FWejZBDyS8ddHz8EWd-rcuYeACIeOdcKx4wunZb7EnEHUMXrhhxNLw>
    <xme:FWejZPiMhmU6Z8nBMcF5AcY9DTZLFTJ-w5In1oUUTw-c7HQu9dmI55J6a1wMSJ_7C
    _1eyzQ4e7q3ceYWYVU>
X-ME-Received: <xmr:FWejZMkt8RjzaJdcjk9MfPGSZlXj6SqJQP9KiBzfyEE_CQUq7P83p278pobU4OYYCIMc3Er5njQFzoG_Ei34Gokb30qKDMdMO2s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevufgjkfhfgggtsehttdertd
    dttddvnecuhfhrohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidq
    mheikehkrdhorhhgqeenucggtffrrghtthgvrhhnpeefieehjedvtefgiedtudethfekie
    elhfevhefgvddtkeekvdekhefftdekvedvueenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:FWejZLyAAha4C2aA-IKLHS7oqd1Rne080ydpVylkDLcqzCH8369E9A>
    <xmx:FWejZGR8TZCW2J-D4iVRrt1yD2AJ80wZQWIn8xvT6fQ4sUSan0mEgQ>
    <xmx:FWejZOZq1vPKMrvz2r3iCHAJgoELVGCZTTJU3l4lP2UjDCHxwBoH-Q>
    <xmx:FWejZJJnyt4yTeKZfTEZUTufoSkrO1BLQEFMdaTR-_JpfcOVH-Tp3g>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jul 2023 20:25:54 -0400 (EDT)
Date:   Tue, 4 Jul 2023 10:26:59 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     gregkh@linuxfoundation.org
cc:     geert@linux-m68k.org, hch@lst.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] nubus: Partially revert proc_create_single_data()
 conversion" failed to apply to 5.10-stable tree
In-Reply-To: <2023070300-copious-unhidden-592f@gregkh>
Message-ID: <28f12be1-7fa1-8de4-b8a9-0dba199ff7d8@linux-m68k.org>
References: <2023070300-copious-unhidden-592f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 3 Jul 2023, gregkh@linuxfoundation.org wrote:

> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 0e96647cff9224db564a1cee6efccb13dbe11ee2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023070300-copious-unhidden-592f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
> 

Thanks for the notification, Greg. I will prepare backports and test them.
