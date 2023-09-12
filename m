Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2B279CEC8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 12:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjILKsg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 06:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjILKsP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 06:48:15 -0400
X-Greylist: delayed 434 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Sep 2023 03:48:10 PDT
Received: from tilde.club (tilde.club [142.44.150.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11EB1726
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 03:48:10 -0700 (PDT)
Received: from [IPv6:::1] (unknown [IPv6:2a03:f680:fe00:a8f:f926:df19:473e:6a88])
        by tilde.club (Postfix) with ESMTPSA id D183222184730;
        Tue, 12 Sep 2023 10:40:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club D183222184730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1694515253; bh=oCzw4WyOJPJp+50oIJ6IiKmd7r26VfSs05xyf/i5w38=;
        h=Date:From:To:CC:Subject:From;
        b=arFjTokM3xO+ua5TlFq7qKmD/HqQoSTCMoazNFETZhLCVAirKdnjkFhxielvbi/IG
         d0WcGa0kouCGw9/joRhi1Z7ERQY6r87WfSlvlZ9TRE6DrD26x9CAPicGXuDqUKKjY0
         SLLqbHJC/XvGVdZyqj3YWCI88/H5KnzYcfe2Moeg=
Date:   Tue, 12 Sep 2023 13:40:47 +0300
From:   Acid Bong <acidbong@tilde.club>
To:     gregkh@linuxfoundation.org
CC:     stable@vger.kernel.org
Subject: No updates in rolling branches
Message-ID: <960C7BCB-CB29-40AE-AA82-CCB470A90DBE@tilde.club>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi there, hello,

I noticed that v6=2E5=2E2 already has patches that are not passed to v6=2E=
4=2Ey, but it's still not merged into `rolling-stable`=2E Do you not merge =
6=2E5=2Ey until 6=2E4=2E15 comes to its EOL? Or haven't pushed the merge?

(re-sent, as suggested by your email bot)

Regards,
~acidbong
