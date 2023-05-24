Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D63B70FD14
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 19:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbjEXRqf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbjEXRqd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 13:46:33 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF4B10CE;
        Wed, 24 May 2023 10:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=yuz9ArgDnVPACpReUH5oMEZEfxp4zwXrDfDOiInJOvE=; b=0ksWKqNVVSgcxoh2U44il/trCt
        jmk6AHgcrdLOrK+dYNpyEIqE8tRTs28bRPkWvBehWzMcb9B+vKLBU02WPBJI8sfw3RVLz+Oq7keNx
        U021KRyN3qSHlAuLNACj1il1xhFRVioQfEtXLQpKckcyWMQXhXKErcaAvOBdv2FesIQ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q1sYY-00Dotu-Cw; Wed, 24 May 2023 19:45:50 +0200
Date:   Wed, 24 May 2023 19:45:50 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     stable <stable@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Steffen =?iso-8859-1?Q?B=E4tz?= <steffen@innosonix.de>
Subject: Re: net: dsa: mv88e6xxx: Request for stable inclusion
Message-ID: <eec26f5c-1ad7-48ff-94a9-708a0a9f3b02@lunn.ch>
References: <CAOMZO5Dd7z+k0X1aOug1K61FMC56u2qG-0s4vPpaMjT-gGVqaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5Dd7z+k0X1aOug1K61FMC56u2qG-0s4vPpaMjT-gGVqaA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 24, 2023 at 02:38:22PM -0300, Fabio Estevam wrote:
> Hi,
> 
> I would like to request the commit below to be applied to the 6.1-stable tree:
> 
> 91e87045a5ef ("net: dsa: mv88e6xxx: Add RGMII delay to 88E6320")
> 
> Without this commit, there is a failure to retrieve an IP address via DHCP.

Please could your provide a Fixes: tag.

       Andrew
