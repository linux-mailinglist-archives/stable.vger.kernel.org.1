Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D487B7ED622
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjKOVfd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbjKOVfc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:35:32 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A96B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=UL8lENppiEaSbeKPLUW4prwK1t4QPwKLtXNCJov895c=;
        t=1700084127; x=1701293727; b=wJXxxiNMSeIAb8KFyzovaAuy46jtwmAjyBVivDAFOY1z23J
        Tm8O2P/1AnINdaTMTQ74pi84wNmPgPcj2ZUdU9Z45BgNFBwKdqq+rZ3Dl/Gk1uCafBbLc+qKIXwL+
        wtXo7XtNz+PqcqdQFecbEdId3gphRdxEwuufeMxsVtThufgzmdiAyWoO0B8aT7U1RxBUG6ganWAno
        cPiRVUhYIG342Aq9hAa60eSy/qmTDZ/OQHGcLrOoUx2wpzpySYki7a3yy8MxpxijK9hNXy9hK+Txr
        vG1hMWGLMcbHvrh1kiZtPSUZU8sPFwZUPdsu+rzZJ9k11Y0d+y7Ai40g4JIVmvXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r3NXR-00000009QHB-3AcP;
        Wed, 15 Nov 2023 22:35:09 +0100
Message-ID: <173d2adc744a2878544c14c3960765587bd96521.camel@sipsolutions.net>
Subject: Re: [PATCH 5.10 010/191] wifi: iwlwifi: Use FW rate for non-data
 frames
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Date:   Wed, 15 Nov 2023 22:35:08 +0100
In-Reply-To: <20231115204645.129133114@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
         <20231115204645.129133114@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Wed, 2023-11-15 at 20:44 +0000, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20

I wouldn't backport this patch anywhere.

First of all, it's only _required_ for real WiFi7 operation, which isn't
supported in any of these old kernels. Secondly, it introduced a
regression wrt. the rates used by the firmware, which, while not that
important, caused some folks to complain.

johannes
