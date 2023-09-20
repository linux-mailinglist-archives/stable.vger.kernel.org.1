Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D6A7A7E62
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjITMRo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbjITMRn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:17:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECDCDD
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:17:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B5DC433BF;
        Wed, 20 Sep 2023 12:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212231;
        bh=/VO9cHL/A/e/ARy69i5k9g4/vUAmXWOSg3YYxwCWiuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ze7iz2EGQAkvmt1dNMfGDeSeUVDm7bSkI0Q8XQthWhKlYZAyFYHMxuIX5Wz7FWKI6
         92XwaN41ZqK0dLjDqbm2Bctc3lV7DIMry7bkNYODf9bvt6HeyfwsYNAaigkouqcObU
         D1fg4kFCxk8Fh2WkE0/LFOrQoCQzud+AKklfu4Sw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, Enrico@vger.kernel.org,
        Weigelt@vger.kernel.org
Subject: [PATCH 4.19 162/273] arch: um: drivers: Kconfig: pedantic formatting
Date:   Wed, 20 Sep 2023 13:30:02 +0200
Message-ID: <20230920112851.532585924@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Enrico Weigelt, metux IT consult <info@metux.net>

[ Upstream commit 75f24f78721048a271e2e50a563f51bcfd6f5c1c ]

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up. Just indention changes.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
Signed-off-by: Richard Weinberger <richard@nod.at>
Stable-dep-of: db4bfcba7bb8 ("um: Fix hostaudio build errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/Kconfig | 352 ++++++++++++++++++++--------------------
 1 file changed, 176 insertions(+), 176 deletions(-)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 2b1aaf7755aac..2638e46f50ccd 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -11,58 +11,58 @@ config STDERR_CONSOLE
 config SSL
 	bool "Virtual serial line"
 	help
-          The User-Mode Linux environment allows you to create virtual serial
-          lines on the UML that are usually made to show up on the host as
-          ttys or ptys.
+	  The User-Mode Linux environment allows you to create virtual serial
+	  lines on the UML that are usually made to show up on the host as
+	  ttys or ptys.
 
-          See <http://user-mode-linux.sourceforge.net/old/input.html> for more
-          information and command line examples of how to use this facility.
+	  See <http://user-mode-linux.sourceforge.net/old/input.html> for more
+	  information and command line examples of how to use this facility.
 
-          Unless you have a specific reason for disabling this, say Y.
+	  Unless you have a specific reason for disabling this, say Y.
 
 config NULL_CHAN
 	bool "null channel support"
 	help
-          This option enables support for attaching UML consoles and serial
-          lines to a device similar to /dev/null.  Data written to it disappears
-          and there is never any data to be read.
+	  This option enables support for attaching UML consoles and serial
+	  lines to a device similar to /dev/null.  Data written to it disappears
+	  and there is never any data to be read.
 
 config PORT_CHAN
 	bool "port channel support"
 	help
-          This option enables support for attaching UML consoles and serial
-          lines to host portals.  They may be accessed with 'telnet <host>
-          <port number>'.  Any number of consoles and serial lines may be
-          attached to a single portal, although what UML device you get when
-          you telnet to that portal will be unpredictable.
-          It is safe to say 'Y' here.
+	  This option enables support for attaching UML consoles and serial
+	  lines to host portals.  They may be accessed with 'telnet <host>
+	  <port number>'.  Any number of consoles and serial lines may be
+	  attached to a single portal, although what UML device you get when
+	  you telnet to that portal will be unpredictable.
+	  It is safe to say 'Y' here.
 
 config PTY_CHAN
 	bool "pty channel support"
 	help
-          This option enables support for attaching UML consoles and serial
-          lines to host pseudo-terminals.  Access to both traditional
-          pseudo-terminals (/dev/pty*) and pts pseudo-terminals are controlled
-          with this option.  The assignment of UML devices to host devices
-          will be announced in the kernel message log.
-          It is safe to say 'Y' here.
+	  This option enables support for attaching UML consoles and serial
+	  lines to host pseudo-terminals.  Access to both traditional
+	  pseudo-terminals (/dev/pty*) and pts pseudo-terminals are controlled
+	  with this option.  The assignment of UML devices to host devices
+	  will be announced in the kernel message log.
+	  It is safe to say 'Y' here.
 
 config TTY_CHAN
 	bool "tty channel support"
 	help
-          This option enables support for attaching UML consoles and serial
-          lines to host terminals.  Access to both virtual consoles
-          (/dev/tty*) and the slave side of pseudo-terminals (/dev/ttyp* and
-          /dev/pts/*) are controlled by this option.
-          It is safe to say 'Y' here.
+	  This option enables support for attaching UML consoles and serial
+	  lines to host terminals.  Access to both virtual consoles
+	  (/dev/tty*) and the slave side of pseudo-terminals (/dev/ttyp* and
+	  /dev/pts/*) are controlled by this option.
+	  It is safe to say 'Y' here.
 
 config XTERM_CHAN
 	bool "xterm channel support"
 	help
-          This option enables support for attaching UML consoles and serial
-          lines to xterms.  Each UML device so assigned will be brought up in
-          its own xterm.
-          It is safe to say 'Y' here.
+	  This option enables support for attaching UML consoles and serial
+	  lines to xterms.  Each UML device so assigned will be brought up in
+	  its own xterm.
+	  It is safe to say 'Y' here.
 
 config NOCONFIG_CHAN
 	bool
@@ -72,43 +72,43 @@ config CON_ZERO_CHAN
 	string "Default main console channel initialization"
 	default "fd:0,fd:1"
 	help
-          This is the string describing the channel to which the main console
-          will be attached by default.  This value can be overridden from the
-          command line.  The default value is "fd:0,fd:1", which attaches the
-          main console to stdin and stdout.
-          It is safe to leave this unchanged.
+	  This is the string describing the channel to which the main console
+	  will be attached by default.  This value can be overridden from the
+	  command line.  The default value is "fd:0,fd:1", which attaches the
+	  main console to stdin and stdout.
+	  It is safe to leave this unchanged.
 
 config CON_CHAN
 	string "Default console channel initialization"
 	default "xterm"
 	help
-          This is the string describing the channel to which all consoles
-          except the main console will be attached by default.  This value can
-          be overridden from the command line.  The default value is "xterm",
-          which brings them up in xterms.
-          It is safe to leave this unchanged, although you may wish to change
-          this if you expect the UML that you build to be run in environments
-          which don't have X or xterm available.
+	  This is the string describing the channel to which all consoles
+	  except the main console will be attached by default.  This value can
+	  be overridden from the command line.  The default value is "xterm",
+	  which brings them up in xterms.
+	  It is safe to leave this unchanged, although you may wish to change
+	  this if you expect the UML that you build to be run in environments
+	  which don't have X or xterm available.
 
 config SSL_CHAN
 	string "Default serial line channel initialization"
 	default "pty"
 	help
-          This is the string describing the channel to which the serial lines
-          will be attached by default.  This value can be overridden from the
-          command line.  The default value is "pty", which attaches them to
-          traditional pseudo-terminals.
-          It is safe to leave this unchanged, although you may wish to change
-          this if you expect the UML that you build to be run in environments
-          which don't have a set of /dev/pty* devices.
+	  This is the string describing the channel to which the serial lines
+	  will be attached by default.  This value can be overridden from the
+	  command line.  The default value is "pty", which attaches them to
+	  traditional pseudo-terminals.
+	  It is safe to leave this unchanged, although you may wish to change
+	  this if you expect the UML that you build to be run in environments
+	  which don't have a set of /dev/pty* devices.
 
 config UML_SOUND
 	tristate "Sound support"
 	help
-          This option enables UML sound support.  If enabled, it will pull in
-          soundcore and the UML hostaudio relay, which acts as a intermediary
-          between the host's dsp and mixer devices and the UML sound system.
-          It is safe to say 'Y' here.
+	  This option enables UML sound support.  If enabled, it will pull in
+	  soundcore and the UML hostaudio relay, which acts as a intermediary
+	  between the host's dsp and mixer devices and the UML sound system.
+	  It is safe to say 'Y' here.
 
 config SOUND
 	tristate
@@ -131,107 +131,107 @@ menu "UML Network Devices"
 config UML_NET
 	bool "Virtual network device"
 	help
-        While the User-Mode port cannot directly talk to any physical
-        hardware devices, this choice and the following transport options
-        provide one or more virtual network devices through which the UML
-        kernels can talk to each other, the host, and with the host's help,
-        machines on the outside world.
+	  While the User-Mode port cannot directly talk to any physical
+	  hardware devices, this choice and the following transport options
+	  provide one or more virtual network devices through which the UML
+	  kernels can talk to each other, the host, and with the host's help,
+	  machines on the outside world.
 
-        For more information, including explanations of the networking and
-        sample configurations, see
-        <http://user-mode-linux.sourceforge.net/old/networking.html>.
+	  For more information, including explanations of the networking and
+	  sample configurations, see
+	  <http://user-mode-linux.sourceforge.net/old/networking.html>.
 
-        If you'd like to be able to enable networking in the User-Mode
-        linux environment, say Y; otherwise say N.  Note that you must
-        enable at least one of the following transport options to actually
-        make use of UML networking.
+	  If you'd like to be able to enable networking in the User-Mode
+	  linux environment, say Y; otherwise say N.  Note that you must
+	  enable at least one of the following transport options to actually
+	  make use of UML networking.
 
 config UML_NET_ETHERTAP
 	bool "Ethertap transport"
 	depends on UML_NET
 	help
-        The Ethertap User-Mode Linux network transport allows a single
-        running UML to exchange packets with its host over one of the
-        host's Ethertap devices, such as /dev/tap0.  Additional running
-        UMLs can use additional Ethertap devices, one per running UML.
-        While the UML believes it's on a (multi-device, broadcast) virtual
-        Ethernet network, it's in fact communicating over a point-to-point
-        link with the host.
-
-        To use this, your host kernel must have support for Ethertap
-        devices.  Also, if your host kernel is 2.4.x, it must have
-        CONFIG_NETLINK_DEV configured as Y or M.
-
-        For more information, see
-        <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
-        has examples of the UML command line to use to enable Ethertap
-        networking.
-
-        If you'd like to set up an IP network with the host and/or the
-        outside world, say Y to this, the Daemon Transport and/or the
-        Slip Transport.  You'll need at least one of them, but may choose
-        more than one without conflict.  If you don't need UML networking,
-        say N.
+	  The Ethertap User-Mode Linux network transport allows a single
+	  running UML to exchange packets with its host over one of the
+	  host's Ethertap devices, such as /dev/tap0.  Additional running
+	  UMLs can use additional Ethertap devices, one per running UML.
+	  While the UML believes it's on a (multi-device, broadcast) virtual
+	  Ethernet network, it's in fact communicating over a point-to-point
+	  link with the host.
+
+	  To use this, your host kernel must have support for Ethertap
+	  devices.  Also, if your host kernel is 2.4.x, it must have
+	  CONFIG_NETLINK_DEV configured as Y or M.
+
+	  For more information, see
+	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
+	  has examples of the UML command line to use to enable Ethertap
+	  networking.
+
+	  If you'd like to set up an IP network with the host and/or the
+	  outside world, say Y to this, the Daemon Transport and/or the
+	  Slip Transport.  You'll need at least one of them, but may choose
+	  more than one without conflict.  If you don't need UML networking,
+	  say N.
 
 config UML_NET_TUNTAP
 	bool "TUN/TAP transport"
 	depends on UML_NET
 	help
-        The UML TUN/TAP network transport allows a UML instance to exchange
-        packets with the host over a TUN/TAP device.  This option will only
-        work with a 2.4 host, unless you've applied the TUN/TAP patch to
-        your 2.2 host kernel.
+	  The UML TUN/TAP network transport allows a UML instance to exchange
+	  packets with the host over a TUN/TAP device.  This option will only
+	  work with a 2.4 host, unless you've applied the TUN/TAP patch to
+	  your 2.2 host kernel.
 
-        To use this transport, your host kernel must have support for TUN/TAP
-        devices, either built-in or as a module.
+	  To use this transport, your host kernel must have support for TUN/TAP
+	  devices, either built-in or as a module.
 
 config UML_NET_SLIP
 	bool "SLIP transport"
 	depends on UML_NET
 	help
-        The slip User-Mode Linux network transport allows a running UML to
-        network with its host over a point-to-point link.  Unlike Ethertap,
-        which can carry any Ethernet frame (and hence even non-IP packets),
-        the slip transport can only carry IP packets.
-
-        To use this, your host must support slip devices.
-
-        For more information, see
-        <http://user-mode-linux.sourceforge.net/old/networking.html>.
-        has examples of the UML command line to use to enable slip
-        networking, and details of a few quirks with it.
-
-        The Ethertap Transport is preferred over slip because of its
-        limitations.  If you prefer slip, however, say Y here.  Otherwise
-        choose the Multicast transport (to network multiple UMLs on
-        multiple hosts), Ethertap (to network with the host and the
-        outside world), and/or the Daemon transport (to network multiple
-        UMLs on a single host).  You may choose more than one without
-        conflict.  If you don't need UML networking, say N.
+	  The slip User-Mode Linux network transport allows a running UML to
+	  network with its host over a point-to-point link.  Unlike Ethertap,
+	  which can carry any Ethernet frame (and hence even non-IP packets),
+	  the slip transport can only carry IP packets.
+
+	  To use this, your host must support slip devices.
+
+	  For more information, see
+	  <http://user-mode-linux.sourceforge.net/old/networking.html>.
+	  has examples of the UML command line to use to enable slip
+	  networking, and details of a few quirks with it.
+
+	  The Ethertap Transport is preferred over slip because of its
+	  limitations.  If you prefer slip, however, say Y here.  Otherwise
+	  choose the Multicast transport (to network multiple UMLs on
+	  multiple hosts), Ethertap (to network with the host and the
+	  outside world), and/or the Daemon transport (to network multiple
+	  UMLs on a single host).  You may choose more than one without
+	  conflict.  If you don't need UML networking, say N.
 
 config UML_NET_DAEMON
 	bool "Daemon transport"
 	depends on UML_NET
 	help
-        This User-Mode Linux network transport allows one or more running
-        UMLs on a single host to communicate with each other, but not to
-        the host.
-
-        To use this form of networking, you'll need to run the UML
-        networking daemon on the host.
-
-        For more information, see
-        <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
-        has examples of the UML command line to use to enable Daemon
-        networking.
-
-        If you'd like to set up a network with other UMLs on a single host,
-        say Y.  If you need a network between UMLs on multiple physical
-        hosts, choose the Multicast Transport.  To set up a network with
-        the host and/or other IP machines, say Y to the Ethertap or Slip
-        transports.  You'll need at least one of them, but may choose
-        more than one without conflict.  If you don't need UML networking,
-        say N.
+	  This User-Mode Linux network transport allows one or more running
+	  UMLs on a single host to communicate with each other, but not to
+	  the host.
+
+	  To use this form of networking, you'll need to run the UML
+	  networking daemon on the host.
+
+	  For more information, see
+	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
+	  has examples of the UML command line to use to enable Daemon
+	  networking.
+
+	  If you'd like to set up a network with other UMLs on a single host,
+	  say Y.  If you need a network between UMLs on multiple physical
+	  hosts, choose the Multicast Transport.  To set up a network with
+	  the host and/or other IP machines, say Y to the Ethertap or Slip
+	  transports.  You'll need at least one of them, but may choose
+	  more than one without conflict.  If you don't need UML networking,
+	  say N.
 
 config UML_NET_VECTOR
 	bool "Vector I/O high performance network devices"
@@ -270,26 +270,26 @@ config UML_NET_MCAST
 	bool "Multicast transport"
 	depends on UML_NET
 	help
-        This Multicast User-Mode Linux network transport allows multiple
-        UMLs (even ones running on different host machines!) to talk to
-        each other over a virtual ethernet network.  However, it requires
-        at least one UML with one of the other transports to act as a
-        bridge if any of them need to be able to talk to their hosts or any
-        other IP machines.
-
-        To use this, your host kernel(s) must support IP Multicasting.
-
-        For more information, see
-        <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
-        has examples of the UML command line to use to enable Multicast
-        networking, and notes about the security of this approach.
-
-        If you need UMLs on multiple physical hosts to communicate as if
-        they shared an Ethernet network, say Y.  If you need to communicate
-        with other IP machines, make sure you select one of the other
-        transports (possibly in addition to Multicast; they're not
-        exclusive).  If you don't need to network UMLs say N to each of
-        the transports.
+	  This Multicast User-Mode Linux network transport allows multiple
+	  UMLs (even ones running on different host machines!) to talk to
+	  each other over a virtual ethernet network.  However, it requires
+	  at least one UML with one of the other transports to act as a
+	  bridge if any of them need to be able to talk to their hosts or any
+	  other IP machines.
+
+	  To use this, your host kernel(s) must support IP Multicasting.
+
+	  For more information, see
+	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
+	  has examples of the UML command line to use to enable Multicast
+	  networking, and notes about the security of this approach.
+
+	  If you need UMLs on multiple physical hosts to communicate as if
+	  they shared an Ethernet network, say Y.  If you need to communicate
+	  with other IP machines, make sure you select one of the other
+	  transports (possibly in addition to Multicast; they're not
+	  exclusive).  If you don't need to network UMLs say N to each of
+	  the transports.
 
 config UML_NET_PCAP
 	bool "pcap transport"
@@ -300,9 +300,9 @@ config UML_NET_PCAP
 	UML act as a network monitor for the host.  You must have libcap
 	installed in order to build the pcap transport into UML.
 
-        For more information, see
-        <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
-        has examples of the UML command line to use to enable this option.
+	  For more information, see
+	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
+	  has examples of the UML command line to use to enable this option.
 
 	If you intend to use UML as a network monitor for the host, say
 	Y here.  Otherwise, say N.
@@ -311,27 +311,27 @@ config UML_NET_SLIRP
 	bool "SLiRP transport"
 	depends on UML_NET
 	help
-        The SLiRP User-Mode Linux network transport allows a running UML
-        to network by invoking a program that can handle SLIP encapsulated
-        packets.  This is commonly (but not limited to) the application
-        known as SLiRP, a program that can re-socket IP packets back onto
-        the host on which it is run.  Only IP packets are supported,
-        unlike other network transports that can handle all Ethernet
-        frames.  In general, slirp allows the UML the same IP connectivity
-        to the outside world that the host user is permitted, and unlike
-        other transports, SLiRP works without the need of root level
-        privleges, setuid binaries, or SLIP devices on the host.  This
-        also means not every type of connection is possible, but most
-        situations can be accommodated with carefully crafted slirp
-        commands that can be passed along as part of the network device's
-        setup string.  The effect of this transport on the UML is similar
-        that of a host behind a firewall that masquerades all network
-        connections passing through it (but is less secure).
-
-        To use this you should first have slirp compiled somewhere
-        accessible on the host, and have read its documentation.  If you
-        don't need UML networking, say N.
-
-        Startup example: "eth0=slirp,FE:FD:01:02:03:04,/usr/local/bin/slirp"
+	  The SLiRP User-Mode Linux network transport allows a running UML
+	  to network by invoking a program that can handle SLIP encapsulated
+	  packets.  This is commonly (but not limited to) the application
+	  known as SLiRP, a program that can re-socket IP packets back onto
+	  he host on which it is run.  Only IP packets are supported,
+	  unlike other network transports that can handle all Ethernet
+	  frames.  In general, slirp allows the UML the same IP connectivity
+	  to the outside world that the host user is permitted, and unlike
+	  other transports, SLiRP works without the need of root level
+	  privleges, setuid binaries, or SLIP devices on the host.  This
+	  also means not every type of connection is possible, but most
+	  situations can be accommodated with carefully crafted slirp
+	  commands that can be passed along as part of the network device's
+	  setup string.  The effect of this transport on the UML is similar
+	  that of a host behind a firewall that masquerades all network
+	  connections passing through it (but is less secure).
+
+	  To use this you should first have slirp compiled somewhere
+	  accessible on the host, and have read its documentation.  If you
+	  don't need UML networking, say N.
+
+	  Startup example: "eth0=slirp,FE:FD:01:02:03:04,/usr/local/bin/slirp"
 
 endmenu
-- 
2.40.1



